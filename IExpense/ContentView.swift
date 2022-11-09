//
//  ContentView.swift
//  IExpense
//
//  Created by Roman on 11/3/22.
//

import SwiftUI

struct CircleView: View{
    
    @State var expenseAmount: Double
    
    func displayCircle(expense: Double) -> some View {
        if expenseAmount < 100{
            return  Image(systemName: "circle.fill").foregroundColor(.green)
        }
        else if expenseAmount < 1000{
            return Image(systemName: "circle.fill").foregroundColor(.yellow )
        }else{
            return Image(systemName: "circle.fill").foregroundColor(.red )
        }
    }
    var body: some View{
        displayCircle(expense: expenseAmount)
    }
}

struct ContentView: View {
    @StateObject var personalExpenses = Expenses()
    @StateObject var businessExpenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View{
        
        NavigationView{
            List{
                Section("Personal"){
                    ForEach(personalExpenses.items, id: \.id){
                        item in
                        HStack(spacing: 50){
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Text(item.amount, format: .currency(code: item.currency))
                            Spacer()
                            CircleView(expenseAmount: item.amount)
                        }
                    }
                    .onDelete(perform: deletePersonal)
                }
                Section("Business"){
                    ForEach(businessExpenses.items, id: \.id){
                        item in
                        HStack(spacing: 50){
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Text(item.amount, format: .currency(code: item.currency))
                            Spacer()
                            CircleView(expenseAmount: item.amount)
                        }    
                    }
                    .onDelete(perform: deleteBusiness)
                }
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                   showingAddExpense = true
                    
                }label:{
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: personalExpenses, businessExpenses: businessExpenses)
            }
        }
    }
    func deletePersonal (at offsets: IndexSet){
        personalExpenses.items.remove(atOffsets: offsets)
    }
    func deleteBusiness (at offsets: IndexSet){
        businessExpenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
