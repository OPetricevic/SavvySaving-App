//
//  TransactionListViewModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 09.07.2023..
//

import Foundation
import FirebaseFirestore
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>

final class ExpensesViewModel: ObservableObject {

    // MARK: - Properties
    @Published var totalIncome: Double = 0
    @Published var totalExpenses: Double = 0
    @Published var totalBalance: Double = 0
    @Published var selectedMonthIndex: Int = 0 // 0 is .all

    var loadedFromDB: Bool = true

    var selectedMonth: Month {
        let month = Month.allCases[selectedMonthIndex]
        return month
    }

    private var transactions: [Transaction] = []

    // MARK: - Services

    let transactionsFetchingService: TransactionsFetchingService

    init(transactionsFetchingService: TransactionsFetchingService = TransactionsFetchingService()) {
        self.transactionsFetchingService = transactionsFetchingService
    }

  @MainActor
    func load() async {
        self.transactions = await transactionsFetchingService.fetchTransactions()
        calculateTotalBalance()
    }

    func calculateTotalBalance() {
        self.totalBalance = calculateTotalIncome() - calculateTotalExpenses()
    }
    
   func calculateTotalIncome() -> Double {
       let totalIncome = sum(of: .income, for: transactionsInSelectedMonth())
       self.totalIncome = totalIncome
       return totalIncome
    }
    
    func calculateTotalExpenses() -> Double {
        let totalExpenses = sum(of: .expense, for: transactionsInSelectedMonth())
        self.totalExpenses = totalExpenses
        return totalExpenses
     }

    func transactionsInSelectedMonth() -> [Transaction] {
        return selectedMonth == .all
            ? transactions
            : transactions.filter { getMonth(from: $0.date) == selectedMonth }
    }

    private func sum(of type: TransactionType, for transactions: [Transaction]) -> Double {
        let filteredTransactions = transactions.filter { $0.type == type }
        let sum = filteredTransactions.reduce(into: 0) { result, transaction in
            result += transaction.amount
        }
        return sum
    }


    private func getMonth(from date: Date) -> Month? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthName = dateFormatter.string(from: date)
        return Month(rawValue: monthName)
    }
}


