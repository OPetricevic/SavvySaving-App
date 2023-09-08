//
//  AddCreateButton.swift
//  SavvySaving
//
//  Created by Omar Petričević on 10.07.2023..
//

import Foundation

func createTransaction(date: Date, merchant: String, amount: Double,type: TransactionType, title: String, categoryType: CategoryType) -> Transaction{
    let newTransaction = Transaction(
        id: UUID(),
        date: date,
        merchant: merchant,
        amount: amount,
        type: type,
        title: title,
        categoryType: categoryType
    )
    
        return newTransaction
}
