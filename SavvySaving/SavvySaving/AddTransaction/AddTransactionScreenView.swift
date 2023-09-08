//
//  AddTransactionScreen.swift
//  SavvySaving
//
//  Created by Omar Petričević on 20.07.23.
//

import SwiftUI

struct AddTransactionScreenView: View {
    @StateObject var viewModel: AddTransactionScreen
    @State private var showingFailingAlert = false
    @State private var showingTransactionAddedAlert = false
    @State private var isSubmitButtonEnabled = false
    
    private var storeSection: some View {
        HStack {
            Text("Store")
            Spacer()
            TextField("Store/Reseller", text: $viewModel.merchant)
                .multilineTextAlignment(.trailing)
                .submitLabel(.next)
                .keyboardType(.default)
                .onSubmit {
                    viewModel.moveToNextSection(currentSection: .merchant)
                }
        }
        .listRowBackground(Color.background)
    }
    
    private var amountSection: some View {
        HStack {
            Text("Amount")
            Spacer()
            TextField("Amount", text: $viewModel.amountString)
                .multilineTextAlignment(.trailing)
                .submitLabel(.next)
                .keyboardType(.decimalPad)
        }
        .listRowBackground(Color.background)
    }
    
    private var titleSection: some View {
        HStack {
            Text("Title")
            Spacer()
            TextField("Expense/Income Title", text: $viewModel.title, onCommit: {
                viewModel.moveToNextSection(currentSection: .title)
                hideKeyboard()
            })
                .multilineTextAlignment(.trailing)
                .submitLabel(.done)
        }
        .listRowBackground(Color.background)
    }
    
    private var currencySection: some View {
        HStack {
            Text("Currency")
            Spacer()
            Picker(selection: $viewModel.currency, label: Text(""), content: {
                Text("EUR").tag(Currency.EUR)
            })
        }
        .listRowBackground(Color.background)
    }
    
    private var dateSection: some View {
        HStack {
            Text("Date")
            Spacer()
            DatePicker(
                selection: $viewModel.date,
                in: viewModel.dateClosedRange,
                displayedComponents: .date,
                label: { Text("") }
            )
        }
        .listRowBackground(Color.background)
    }
    
    private var typeSection: some View {
        HStack {
            Text("Type")
            Spacer()
            Picker(selection: $viewModel.transactionType, label: Text(""), content: {
                Text("Expense").tag(TransactionType.expense)
                Text("Income").tag(TransactionType.income)
            })
        }
        .listRowBackground(Color.background)
    }
    
    private var categorySection: some View {
        HStack {
            Text("Category")
            Spacer()
            Picker(selection: $viewModel.categoryType, label: Text(""), content: {
                Text("Rent").tag(CategoryType.rent)
                Text("Auto & Transport").tag(CategoryType.autoTransport)
                Text("Bills & Utilities").tag(CategoryType.billsUtilities)
                Text("Food").tag(CategoryType.food)
                Text("Healthcare & Insurance").tag(CategoryType.healthcareInsurance)
                Text("Hygiene").tag(CategoryType.hygiene)
                Text("Entertainment").tag(CategoryType.entertainment)
                Text("Savings").tag(CategoryType.savings)
                Text("Paycheck").tag(CategoryType.paycheck)
                Text("Other").tag(CategoryType.other)
            })
        }
        .listRowBackground(Color.background)
    }
    
    private var submitButton: some View {
        Button {
            let saveResult = viewModel.save()
            switch saveResult {
            case .success:
                showingTransactionAddedAlert = true
                viewModel.resetInputFields()
            case .failure:
                showingFailingAlert = true
            }
        } label: {
            Label("Submit Transaction", image: "plus")
                .labelStyle(.titleOnly)
                .padding(.horizontal)
                .padding(.vertical, 12)
        }
        .foregroundColor(.text)
        .background(Color.viewOrange)
        .cornerRadius(20)
        .disabled(!isSubmitButtonEnabled)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                List {
                    storeSection
                    amountSection
                    titleSection
                    currencySection
                    dateSection
                    typeSection
                    categorySection
                }
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
                
                submitButton
                    .alert(isPresented: $showingFailingAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("An error occurred while adding the transaction."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .alert(isPresented: $showingTransactionAddedAlert) {
                        Alert(
                            title: Text("Transaction Added"),
                            message: Text("Your transaction has been added successfully."),
                            dismissButton: .default(Text("OK")) {
                                viewModel.dismissConfirmationSheet()
                            }
                        )
                    }
            }
            .padding()
            .background(Color.background)
            .navigationTitle("Add")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        hideKeyboard()
                    } label: {
                        Label("Dismiss", systemImage: "keyboard.chevron.compact.down.fill")
                    }
                }
            }
            .task {
                await viewModel.load()
            }
            .onChange(of: [viewModel.merchant, viewModel.amountString, viewModel.title]) { _ in
                isSubmitButtonEnabled = !viewModel.merchant.isEmpty && !viewModel.amountString.isEmpty && !viewModel.title.isEmpty
            }
        }
    }
}


//struct AddTransactionScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTransactionScreen(merchant: .constant("merchant"))
//    }
//}
