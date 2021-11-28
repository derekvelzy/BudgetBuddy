//
//  AddView.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/28/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var items: Expenses
    
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var category = "food"
    @State private var amount = 0.0
    var categories = ["food", "groceries", "miscellaneous"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Add new expense")
            .toolbar {
                //save
                Button("Save") {
                    let expenseItem = Expense(name: name, amount: amount, category: category)
                    items.expenses.append(expenseItem)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Preview: PreviewProvider {
    static var previews: some View {
        AddView(items: Expenses())
    }
}
