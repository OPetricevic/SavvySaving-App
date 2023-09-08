//
//  IncomeExpensesCalculatorViewModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 17.07.2023..
//

import Foundation
import FirebaseFirestore
import Combine

final class IncExpCalculatorViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var currentMonthIncome: Double = 0
    @Published var currentMonthExpenses: Double = 0
    
    // Create an instance of IncomeExpensesDataModel here
    private var incomeExpensesDataModel = IncomeExpensesDataModel()
    private var transactionListViewModel: TransactionListViewModel

    init() {
        self.transactionListViewModel = TransactionListViewModel()
        self.transactionListViewModel.loadTransactions() // Load transactions from TransactionListViewModel
        self.updateCurrentMonthTotals() // Update current month totals after loading transactions
    }
        
    func updateCurrentMonthTotals() {
        // Access the transactions from TransactionListViewModel
        transactions = transactionListViewModel.transactions

        let currentDate = Date()
        let currentMonth = Calendar.current.component(.month, from: currentDate)
        let currentYear = Calendar.current.component(.year, from: currentDate)
        
        let currentMonthTransactions = transactions.filter { transaction in
            let transactionMonth = Calendar.current.component(.month, from: transaction.date)
            let transactionYear = Calendar.current.component(.year, from: transaction.date)
            return transactionMonth == currentMonth && transactionYear == currentYear
        }
        
        print("All Transactions: \(transactions)")
            print("Current Month Transactions: \(currentMonthTransactions)")
        
        currentMonthIncome = currentMonthTransactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
            .rounded(toPlaces: 2)
        
        
        currentMonthExpenses = currentMonthTransactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
            .rounded(toPlaces: 2)
        
    }
}
