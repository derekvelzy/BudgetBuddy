//
//  Expenses.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/27/21.
//

import Foundation

class Expenses: ObservableObject {
    @Published var expenses = [Expense]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(expenses) {
                UserDefaults.standard.set(encoded, forKey: "Expenses")
            }
        }
    }
    
    init() {
        
        if let savedItems = UserDefaults.standard.data(forKey: "Expenses") {
            // If we can read it, attempt to decode it as an array of ExpenseItem
            if let decodedItems = try? JSONDecoder().decode([Expense].self, from: savedItems) {
                // we use ".self" here because swift wants to know what we mean.
                // are we making a copy of the array?
                // are we trying to make a new one?
                // no, we're refering to the array type itself
                expenses = decodedItems
                return
            }
        }
        // else
        expenses = []
    }
}
