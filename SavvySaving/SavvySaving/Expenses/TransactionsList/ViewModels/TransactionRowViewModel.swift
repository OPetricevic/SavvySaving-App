//
//  TransactionRowViewModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 09.07.2023..
//

import SwiftUI

class TransactionRowViewModel: ObservableObject {
    var transaction: Transaction

    var transactionDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        return dateFormatter.string(from: transaction.date)
    }

    var transactionSignedAmount: String {
        transaction.signedAmount.formatted(.currency(code: Currency.EUR.rawValue))
    }

    var transactionTypeColor: Color {
        transaction.type == .expense ? .expenseColor : .viewOrange
    }

    init(transaction: Transaction) {
        self.transaction = transaction
    }
}



