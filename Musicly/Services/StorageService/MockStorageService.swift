//
//  MockStorageService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

final class MockStorageService: MockModuleService, StorageService {

    private let userDefaults: UserDefaults
    private static let userDefaultsSuiteName: String = "MockVehicleService.userDefaults"

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

    override init() {
        guard let userDefaults = UserDefaults(suiteName: MockStorageService.userDefaultsSuiteName) else {
            fatalError("Impossible to create a UserDefaults instance with suiteName \(MockStorageService.userDefaultsSuiteName)")
        }
        self.userDefaults = userDefaults
    }

    func get<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let savedData = userDefaults.data(forKey: key) else {
            return nil
        }
        do {
            return try self.decoder.decode(T.self, from: savedData)
        } catch {
            if let decodingError = error as? DecodingError {
                print("JSON decoding error: \(String(describing: decodingError))")
            }
            return nil
        }
    }

    func getObjects<T: Persistable>(_ type: T.Type) -> [T] {
        return []
    }

    func store<T: Encodable>(_ object: T, forKey key: String) {
        do {
            let data = try self.encoder.encode(object)
            userDefaults.set(data, forKey: key)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeObject(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    func fetch<T: Persistable>(_ type: T.Type, forKey key: String) -> T? {
        return nil
    }

    func add<T: Persistable>(_ object: T) {
        //
    }

    func delete<T: Persistable>(_ object: T, cascade: Bool) {
        //
    }

    func removeAllObjects() {
        //
        UserDefaults.standard.removePersistentDomain(forName: MockStorageService.userDefaultsSuiteName)
    }
}
