//
//  ContentView.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/26/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var items = Expenses()
    @State private var add = false

    var body: some View {
        NavigationView {
            List {
                ForEach(items.expenses, id: \.id) {
                    item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.category)
                        }
                        
                        Spacer()
                        
                        Text(String(item.amount))
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("Budget")
            .toolbar {
                Button("Adds") {
                    add.toggle()
                }
            }
            .sheet(isPresented: $add) {
                AddView(items: items)
            }

        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.expenses.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
