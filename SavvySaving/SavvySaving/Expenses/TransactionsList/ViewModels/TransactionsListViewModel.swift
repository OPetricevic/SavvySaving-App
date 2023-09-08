// TransactionsListViewModel.swift

import Foundation
import Firebase

final class TransactionsListViewModel: ObservableObject {
    
    @Published var transactions: [Transaction]
    
    
    var expensesViewModel: ExpensesViewModel

       init(transactions: [Transaction], expensesViewModel: ExpensesViewModel) {
           self.transactions = transactions
           self.expensesViewModel = expensesViewModel
           sortedTransactionByDate()
       }
    
    
    func sortedTransactionByDate() {
        transactions = transactions.sorted(by: {$0.date > $1.date})
    }
    
    func deleteTransaction(at index: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let database = Firestore.firestore()
        let transaction = transactions[index]
        let documentID = transaction.id.uuidString
        let documentReference = database.collection(Constants.collectionName).document(documentID)
        
        documentReference.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                Task {
                    await self.expensesViewModel.load()
                }
                completion(.success(()))
                
            }
        }
    }
}
