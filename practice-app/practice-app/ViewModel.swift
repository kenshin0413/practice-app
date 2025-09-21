//
//  ViewModel.swift
//  practice-app
//
//  Created by miyamotokenshin on R 7/09/20.
//

import Foundation
import SwiftUI

class NumberListViewModel: ObservableObject {
    @Published var items: [Number] = []
    @Published var isEditing = false
    @Published var showDeleteAlert = false
    @Published var deleteOffsets: IndexSet?
    @Published var search = ""
    @Published var matchedValue: Int?
    @Published var showAlert = false
    @Published var inputValue = ""
    @Published var sliderValue: Double = 100
    @AppStorage("savedNumber") var savedNumber: Int?
    
    init() {
        self.items = NumberStorage.load()
    }
    
    var filteredItems: [Number] {
        if search.isEmpty {
            return items
        } else {
            return items.filter { item in
                ("\(item.value)".contains(search))
            }
        }
    }
    
    func deleteItems(at offset: IndexSet) {
        items.remove(atOffsets: offset)
    }
    
    func addRandomNumber(OnlyEven: Bool? = nil) {
        var newValue: Int
        repeat {
            newValue = Int.random(in: 0...Int(sliderValue))
        } while (OnlyEven == true && newValue % 2 != 0) ||
        (OnlyEven == false && newValue % 2 == 0)
        
        items.append(Number(value: newValue))
        
        if let target = savedNumber, target == newValue {
            matchedValue = newValue
            showAlert = true
        }
    }
    
    func reset() {
        items = []
    }
    
    func save() {
        NumberStorage.save(items)
    }
    
    func savedLuckyNumber() -> Bool {
        if let num = Int(inputValue), (0...Int(sliderValue)).contains(num) {
            savedNumber = num
            inputValue = ""
            return true
        }
        return false
    }
}
