//
//  TransactionList.swift
//  SavvySaving
//
//  Created by Omar Petričević on 08.07.2023..
//

import SwiftUI
import FirebaseFirestore

struct TransactionsListView: View {
    @ObservedObject var transactionListViewModel: TransactionsListViewModel
    @StateObject var viewModel: AddTransactionScreen
    @Binding var selectedMonthIndex: Int
    @State private var showingDeleteConfirmation = false
    @State private var selectedIndexToDelete: Int?
    
    let months = Month.allCases
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()

                Spacer()

                Picker("Select Month", selection: $selectedMonthIndex) {
                    ForEach(0..<Month.allCases.count, id: \.self) { index in
                        Text(Month.allCases[index].rawValue)
                    }
                }
            }
            .padding(.top)
            
            List {
                ForEach(transactionListViewModel.transactions) { transaction in
                    TransactionRowView(transactionRowViewModel: TransactionRowViewModel(transaction: transaction))
                        .listRowBackground(Color.background)
                        .swipeActions {
                            Button(action:{
                                //MARK: - Perform Delete Action
                                if let selectedIndex = transactionListViewModel.transactions.firstIndex(where: { $0.id == transaction.id }) {
                                    selectedIndexToDelete = selectedIndex
                                    showingDeleteConfirmation = true
                                }
                            }, label: {
                                Label("Delete", systemImage: "trash")
                            })
                        }
                        .tint(.red)
                }
            }
            .listStyle(PlainListStyle())
            .listRowInsets(EdgeInsets())
            .background(Color.background)
            .task {
                await viewModel.load()
            }
        }
        .alert(isPresented: $showingDeleteConfirmation) {
            Alert(
                title: Text("Confirm Delete"),
                message: Text("Are you sure you want to delete this transaction?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let indexToDelete = selectedIndexToDelete {
                        transactionListViewModel.deleteTransaction(at: indexToDelete) { result in
                            switch result {
                            case .success:
                                Task {
                                    await viewModel.load()
                                }
                            case .failure(let error):
                                print("Error deleting transaction \(error)")
                            }
                        }
                    }
                    selectedIndexToDelete = nil
                }, secondaryButton: .cancel {
                    selectedIndexToDelete = nil
                }
            )
        }
    }
}


