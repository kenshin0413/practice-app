//
//  ModelView.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/08.
//

import Foundation

struct Number: Identifiable, Codable {
    var id = UUID()
    let value: Int
}
