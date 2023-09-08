//
//  ContentView.swift
//  SavvySaving
//
//  Created by Omar Petričević on 05.07.2023..
//

import SwiftUI

struct RootView: View {
    let transactionsFetchingService = TransactionsFetchingService.shared

    var body: some View {
        TabView {
            ExpensesScreen(expensesViewModel: ExpensesViewModel(transactionsFetchingService: transactionsFetchingService))
            .tabItem {
                Label("Home", systemImage: "house")
            }

            AddTransactionScreenView(viewModel: AddTransactionScreen(transactionsFetchingService: transactionsFetchingService))
            .tabItem {
                Label("Add Transaction", systemImage: "plus.circle")
            }

            Settings()
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
