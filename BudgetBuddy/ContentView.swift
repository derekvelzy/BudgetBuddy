//
//  ContentView.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/28/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var items = Expenses()
    @ObservedObject var categories: Categories
    @State private var add = false
    @State private var amount = 0.0

    var body: some View {
        NavigationView {
            List {
                ForEach(items.expenses, id: \.id) {
                    item in
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.category)
                            }
                            
                            Spacer()
                            
                            Text(String(item.amount))
                        }
                        
                        Text("Edit amount")
                        
                        TextField(String(item.amount), value: $amount, format: .currency(code: "USD") )
                            .background(.gray)
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Budget")
            .toolbar {
                Button{
                    add.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $add) {
                AddView(items: items, categories: categories)
            }

        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        
    
        print(offsets[offsets.startIndex])
        let deletedIndex = offsets[offsets.startIndex]
        let categoryName = items.expenses[deletedIndex].category
        print(categoryName)
        for i in 0..<categories.categories.count {
            if categoryName == categories.categories[i].name {
                categories.categories[i].paid -= items.expenses[deletedIndex].amount
            }
        }
        items.expenses.remove(atOffsets: offsets)
    }}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
