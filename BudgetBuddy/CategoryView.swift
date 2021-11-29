//
//  CategoryView.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/28/21.
//

import SwiftUI

struct CategoryView: View {
    @State private var text = ""
    @State private var amount = 0.0
    @State private var alert = false
    @State private var alertMessage = ""
    @ObservedObject var items: Categories
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $text)
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                
                Button("submit") {
                    var match = false
                    for item in items.categories {
                        if item.name.lowercased() == text.lowercased() {
                           match = true
                        }
                    }
                    
                    if amount <= 0.0 {
                        alertMessage = "Please enter valid amount"
                        alert.toggle()
                    } else if match {
                        alertMessage = "Item already found"
                        alert.toggle()
                    } else {
                        let cat = Category(name: text, amount: amount, paid: 0.0)
                        items.categories.append(cat)
                        dismiss()
                    }
                }
                .alert(alertMessage, isPresented: $alert) {
                    Button("OK") {}
                }
            }
            .navigationTitle("Add category")
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

//struct CategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryView()
//    }
//}
