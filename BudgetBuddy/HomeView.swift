//
//  HomeView.swift
//  BudgetBuddy
//
//  Created by Derek Velzy on 11/26/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var items = Categories()
    @State var addNew = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    List {
                        ForEach(items.categories) {
                            item in
                            HStack {
                                Text(item.name)
                                    .font(.headline)
                                Spacer()
                                Text("$ \(String(item.paid)) / \(String(item.amount))")
                            }
            
                        }
                        .onDelete(perform: deleteItem)

                    }
        
                    Button("Add new category") {
                        addNew.toggle()
                    }
                }
                
            }
            .navigationTitle("Home")
            .sheet(isPresented: $addNew) {
                CategoryView(items: items)
            }
            .toolbar {
                if items.categories.count > 0 {
                    NavigationLink {
                        ContentView(categories: items)
                    } label: {
                        Text("Monthly Spending")
                    }
                }
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.categories.remove(atOffsets: offsets)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
