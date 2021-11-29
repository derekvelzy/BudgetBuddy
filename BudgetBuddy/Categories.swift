//
//  Categories.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/28/21.
//

import Foundation

struct Category: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var amount: Double
    var paid: Double
}

class Categories: ObservableObject {
    @Published var categories: [Category] {
        didSet {
            if let encoded = try? JSONEncoder().encode(categories) {
                UserDefaults.standard.set(encoded, forKey: "Categories")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Categories") {
            // If we can read it, attempt to decode it as an array of ExpenseItem
            if let decodedItems = try? JSONDecoder().decode([Category].self, from: savedItems) {
                // we use ".self" here because swift wants to know what we mean.
                // are we making a copy of the array?
                // are we trying to make a new one?
                // no, we're refering to the array type itself
                categories = decodedItems
                return
            }
        }
        // else
        categories = []
    }
}
