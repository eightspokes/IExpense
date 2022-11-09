//
//  ExpenseItem.swift
//  IExpense
//
//  Created by Roman on 11/4/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}
