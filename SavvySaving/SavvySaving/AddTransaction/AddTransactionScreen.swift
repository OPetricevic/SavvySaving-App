//
//  AddTransactionViewModelAmel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 20.07.23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

final class AddTransactionScreen: ObservableObject {
    @Published var amountString: String = String()
    @Published var currency: Currency = .EUR
    @Published var recurrence: Recurrence = .daily
    @Published var date: Date = Date()
    @Published var title: String = ""
    @Published var transactionType: TransactionType = .expense
    @Published var merchant: String = ""
    @Published var categoryType: CategoryType = .autoTransport
    @Published var isShowingConfirmationSheet = false
    
    let db = Firestore.firestore()
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to:Date())!
        let max = Date()
        return min...max
    }

    private var transactions: [Transaction] = []

    let transactionsFetchingService: TransactionsFetchingService

    init(transactionsFetchingService: TransactionsFetchingService) {
        self.transactionsFetchingService = transactionsFetchingService
    }

    @MainActor
    func load() async {
        self.transactions = await transactionsFetchingService.fetchTransactions()
    }

    func save() -> TransactionResult {
        let newTransaction: Transaction = Transaction(
            id: UUID(), date: date, merchant: merchant, amount: Double(amountString) ?? 0, type: transactionType, title: title, categoryType: categoryType)

        do {
            let collectionRef = db.collection(Constants.collectionName)
            
            try collectionRef.document(newTransaction.id.uuidString).setData(from: newTransaction)
            isShowingConfirmationSheet = true
            print("Saved Properly")
            resetInputFields()
            return .success
        }
        catch let error {
            print("Error writing data to Firestore: \(error)")
            return .failure(error)
        }
    }
    
    func dismissConfirmationSheet() {
            isShowingConfirmationSheet = false
        }
    
    enum TransactionResult {
        case success
        case failure(Error)
    }
    
    func resetInputFields() {
        merchant = ""
        amountString = ""
        title = ""
        currency = .EUR
        recurrence = .daily
        date = Date()
        transactionType = .expense
        categoryType = .autoTransport
    }
    
    enum ActiveSection {
          case amount
          case title
          case merchant
      }
    
    @Published var activeSection: ActiveSection = .amount
        
    func moveToNextSection(currentSection: ActiveSection) {
        switch currentSection {
        case .merchant:
            activeSection = .merchant
        case .amount:
            activeSection = .amount
        case .title:
            activeSection = .title
            hideKeyboard()
        }
    }
}
