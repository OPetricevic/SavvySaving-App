//
//  ExpenseModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 07.07.2023..
//

import SwiftUI

struct ExpenseModel: Identifiable, Hashable{
    var id = UUID().uuidString
    var remark: String
    var amount: Double
    var date: Date
    var type: ExpenseType
    var color: String
    
    
}

enum ExpenseType: String {
    case income = "Income"
    case expense = "Expenses"
}


