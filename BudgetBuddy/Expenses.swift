//
//  Expenses.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/27/21.
//

import Foundation

class Expenses: ObservableObject {
    @Published var expenses = [Expense]()
    
    init() {
        let expense1 = Expense(name: "Tacos", amount: 12.99, category: "Eating out")
        let expense2 = Expense(name: "Whole Foods", amount: 86.54, category: "Groceries")
        let expense3 = Expense(name: "Moto insurance", amount: 120.23, category: "Vehicles")
        
        expenses.append(expense1)
        expenses.append(expense2)
        expenses.append(expense3)
    }
}
