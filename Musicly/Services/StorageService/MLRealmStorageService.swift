//
//  MLRealmStorageService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation
import RealmSwift

protocol Keyable {
    static var primaryKey: String { get }
}

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

@objcMembers
class KeyValueWrapper: Object {
    dynamic var key: String!
    dynamic var data: Data!
    dynamic var json: String!
    dynamic var updatedAt: Date!

    private struct JSONWrapper<T: Codable>: Codable {
        let value: T
    }

    func getValue<T: Codable>() -> T? {
        do {
            return try self.decoder.decode(JSONWrapper<T>.self, from: data).value
        } catch {
            if let decodingError = error as? DecodingError {
                assert(false, "JSON decoding error: \(String(describing: decodingError))")
            }
            return nil
        }
    }

    func setValue<T: Codable>(_ object: T) throws {
        data = try self.encoder.encode(JSONWrapper<T>(value: object))
        json = String(data: data, encoding: .utf8)
        updatedAt = Date()
    }

    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return encoder
    }()

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()

    override class func primaryKey() -> String? { return "key" }
}

class MLRealmStorageService: AppModuleService, StorageService {

    // MARK: - Realm Storage Service version

    override var version: UInt { return 1 }

    private let realm: Realm!

    override init() {
        let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = configuration
        do {
            self.realm = try Realm()
        } catch let error as NSError {
            fatalError("Realm error: \(error.localizedDescription)")
        }
        super.init()
        self.loggerService.log("Realm Storage: \(realm.configuration.fileURL?.absoluteString ?? "nil")", level: .debug)
    }

    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        self.loggerService.log("Get<Codable> for key: \(key).")
        guard let savedValue = self.realm.objects(KeyValueWrapper.self).filter("key == '\(key)'").first else {
            return nil
        }
        return savedValue.getValue()
    }

    func store<T: Codable>(_ object: T, forKey key: String) {
        self.loggerService.log("Store<Codable> for key: \(key).")
        guard Thread.current.isMainThread else {
            fatalError("Realm cannot be cannot used in another thread than the main one")
        }
        do {
            let wrapper = KeyValueWrapper()
            wrapper.key = key
            try wrapper.setValue(object)
            try self.realm.write {
                self.realm.add(wrapper, update: .all)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeObject(forKey key: String) {
        self.loggerService.log("RemoveObject<Codable> for key: \(key).")
        guard let object = self.realm.object(ofType: KeyValueWrapper.self, forPrimaryKey: key) else {
            return
        }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    // Realm object storage

    func fetch<T: Persistable>(_ type: T.Type, forKey key: String) -> T? {
        self.loggerService.log("Fetch<Persistable> for key: \(key).")
        guard let object = self.realm.object(ofType: T.ManagedObject.self, forPrimaryKey: key) else {
            return nil
        }
        return T.init(managedObject: object)
    }

    func add<T: Persistable>(_ object: T) {
        self.loggerService.log("Add<Persistable> object: \(object).")
        do {
            try realm.write {
                realm.add(object.managedObject(), update: .all)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func delete<T: Persistable>(_ object: T, cascade: Bool) {
        self.loggerService.log("Delete<Persistable> managed object: \(object.managedObject())")
        let managedObject: T.ManagedObject = object.managedObject()
        guard let primaryKey: String = type(of: managedObject).primaryKey() else {
            fatalError("Primary key does not exist")
        }
        guard let objectToDelete = self.realm.object(ofType: T.ManagedObject.self, forPrimaryKey: managedObject.value(forKey: primaryKey)) else {
            return
        }
        if cascade {
            cascadeDelete(objectToDelete)
        } else {
            do {
                try realm.write {
                    realm.delete(objectToDelete)
                }
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    func removeAllObjects() {
        self.loggerService.log("RemoveAllObjects().")
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func getObjects<T: Persistable>(_ type: T.Type) -> [T] {
        let realmResults = self.realm.objects(T.ManagedObject.self)
        return Array(realmResults).map({ T(managedObject: $0) })
    }
}

// based on: https://gist.github.com/krodak/b47ea81b3ae25ca2f10c27476bed450c
import Realm
extension MLRealmStorageService {
    private func cascadeDelete(_ entity: RLMObjectBase) {
        guard let entity = entity as? Object else { return }
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(entity)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object,
                !element.isInvalidated else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
        }
    }

    private func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        element.objectSchema.properties.forEach {
            guard let value = element.value(forKey: $0.name) else { return }
            if let entity = value as? RLMObjectBase {
                toBeDeleted.insert(entity)
            } else if let list = value as? RealmSwift.ListBase {
                for index in 0..<list._rlmArray.count {
                    if let objectToDelete = list._rlmArray.object(at: index) as? RLMObjectBase {
                        toBeDeleted.insert(objectToDelete)
                    } else {
                        return
                    }
                }
            }
        }
        do {
            try realm.write {
                realm.delete(element)
            }
        } catch {
            fatalError(error.localizedDescription)
        }

    }
}
