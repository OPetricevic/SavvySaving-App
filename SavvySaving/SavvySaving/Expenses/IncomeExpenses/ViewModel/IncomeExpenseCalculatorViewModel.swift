//
//  IncomeExpensesCalculatorViewModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 17.07.2023..
//

import Foundation
import FirebaseFirestore
import Combine


final class IncomeExpenseCalculatorViewModel: ObservableObject {
    @Published var currentMonthIncome: Double = 0
    @Published var currentMonthExpenses: Double = 0

    var transactionListViewModel: ExpensesViewModel
    
    init(transactionListViewModel: ExpensesViewModel) {
        self.transactionListViewModel = transactionListViewModel
    }
    
    func updateCurrentMonthTotals() {
        let transactions = transactionListViewModel.transactionsInSelectedMonth()
        print("\(transactions)")
        let currentDate = Date()
        let currentMonth = Calendar.current.component(.month, from: currentDate)
        let currentYear = Calendar.current.component(.year, from: currentDate)

        let currentMonthTransactions = transactions.filter { transaction in
            let transactionMonth = Calendar.current.component(.month, from: transaction.date)
            let transactionYear = Calendar.current.component(.year, from: transaction.date)
            return transactionMonth == currentMonth && transactionYear == currentYear
        }

        currentMonthIncome = currentMonthTransactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
            .rounded(toPlaces: 2)
        print("All Transactions: \(transactions)")
        print("Current Month Transactions: \(currentMonthTransactions)")

        currentMonthExpenses = currentMonthTransactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
            .rounded(toPlaces: 2)
        print("Current Month Income: \(currentMonthIncome)")
        print("Current Month Expenses: \(currentMonthExpenses)")

    }
}




