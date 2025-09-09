//
//  NumberStorageView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/08.
//

import Foundation

class NumberStorage {
    static let key = "savedNumbers"
    
    static func save(_ items: [Number]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    static func load() -> [Number] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Number].self, from: data) {
            return decoded
        }
        return []
    }
}
