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
    @State private var category = Categories().categories[0]
    @State private var amount = 0.0
    @State private var alert = false
    @State private var alertMessage = ""
    @ObservedObject var categories: Categories
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Category", selection: $category) {
                    ForEach(categories.categories) {
                        cat in
                        Text(cat.name).tag(cat)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Add new expense")
            .toolbar {
                //save
                Button("Save") {
                    saveItem()
                }
                .alert(alertMessage, isPresented: $alert) {
                    Button("OK") {}
                }
            }
        }
    }
    
    func saveItem() {
        if name == "" {
            alertMessage = "Please enter expense name"
            alert.toggle()
        } else if amount == 0.0 {
            alertMessage = "Please enter valid amount"
            alert.toggle()
        } else {
            let expenseItem = Expense(name: name, amount: amount, category: category.name)
            // update amount paid for each category
            for i in 0..<categories.categories.count {
                if category.id == categories.categories[i].id {
                    categories.categories[i].paid += amount
                }
            }
            items.expenses.append(expenseItem)
            dismiss()
        }
    }
}

struct AddView_Preview: PreviewProvider {
    static var previews: some View {
        AddView(items: Expenses(), categories: Categories())
    }
}
