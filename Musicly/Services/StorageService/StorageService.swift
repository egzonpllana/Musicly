//
//  StorageService.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/17/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation

protocol StorageService {
    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T?
    func getObjects<T: Persistable>(_ type: T.Type) -> [T]
    func store<T: Codable>(_ object: T, forKey key: String)
    func removeObject(forKey key: String)

    func fetch<T: Persistable>(_ type: T.Type, forKey key: String) -> T?
    func add<T: Persistable>(_ object: T)
    func delete<T: Persistable>(_ object: T, cascade: Bool)
    func removeAllObjects()
}
