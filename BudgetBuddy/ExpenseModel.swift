//
//  ExpenseModel.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/27/21.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id = UUID()
    var name: String
    var amount: Double
    var category: String
}
