//
//  AddView.swift
//  IExpense
//
//  Created by Roman on 11/6/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @ObservedObject var businessExpenses: Expenses 
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    @State private var currency = "USD"
    let types = ["Business","Personal"]
    let currencyArray = ["USD", "GBP", "WON","LKR","SEK", "CAD","CZK","IDR"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types,id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
                TextField("Amount", value: $amount, format: .currency(code: currency))
                Picker("Currensy", selection: $currency) {
                    ForEach(currencyArray, id: \.self){
                        Text($0)
                    }
                }
           
                Button("Submit"){
                        if name != "" && type != "" && amount > 0 {
                            addExpense()
                        }else{
                        }
                        dismiss()
                }
            }
        }
    }
    func addExpense(){
        let expense = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
        if type == "Personal"{
            expenses.items.append(expense)
        }else{
            businessExpenses.items.append(expense)
        }
        
        
    }
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), businessExpenses: Expenses())
    }
}
