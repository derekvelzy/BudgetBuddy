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
        items.expenses.remove(atOffsets: offsets)
    }}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
