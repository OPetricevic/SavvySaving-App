//
//  AddCreateButton.swift
//  SavvySaving
//
//  Created by Omar Petričević on 10.07.2023..
//

import Foundation

func addTransaction(date: Date, merchant: String, amount: Double,type: TransactionType, title: String, in transactions: inout [Transaction]){
    var newTransaction = Transaction(
        id: UUID(),
        date: date,
        merchant: merchant,
        amount: amount,
        type: type,
        title: title)
    
    transactions.append(newTransaction)
}
