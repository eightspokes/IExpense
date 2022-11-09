//
//  Expenses.swift
//  IExpense
//
//  Created by Roman on 11/4/22.
//

import Foundation

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem](){
        didSet{
            let encoded = JSONEncoder()
            if let encoded = try? encoded.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}
