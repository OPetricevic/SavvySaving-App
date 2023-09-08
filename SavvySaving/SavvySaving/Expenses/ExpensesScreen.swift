//
//  Expenses.swift
//  SavvySaving
//
//  Created by Omar Petričević on 05.07.2023..
//

import SwiftUI


struct ExpensesScreen: View {
    @ObservedObject var expensesViewModel: ExpensesViewModel

    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                TotalBalanceView(totalBalance: $expensesViewModel.totalBalance)
                IncomeExpensesView(totalIncome: $expensesViewModel.totalIncome, totalExpenses: $expensesViewModel.totalExpenses)
               
                TransactionsListView(
                    transactionListViewModel: TransactionsListViewModel(transactions: expensesViewModel.transactionsInSelectedMonth(), expensesViewModel: expensesViewModel), viewModel: AddTransactionScreen(transactionsFetchingService: TransactionsFetchingService()),
                    selectedMonthIndex: $expensesViewModel.selectedMonthIndex
                )
                Spacer()
            }
            .padding()
            .background(Color.background)
            .navigationTitle("Dashboard")
            .onChange(of: expensesViewModel.selectedMonth, perform: { newValue in
                expensesViewModel.calculateTotalBalance()
            })
            .task {
                await expensesViewModel.load()
            }
        }
    }
}

struct Expenses_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesScreen(expensesViewModel: ExpensesViewModel())
    }
}
