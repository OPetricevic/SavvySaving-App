import Foundation
import FirebaseFirestore
import Collections

final class TransactionsFetchingService: ObservableObject {
    static let shared = TransactionsFetchingService()

    var transactions: [Transaction] = []

    func fetchTransactions() async -> [Transaction] {
        let dataBase = Firestore.firestore()
        var transactions: [Transaction] = []

        do {
            let snapshot = try await dataBase.collection(Constants.collectionName).getDocuments()
            snapshot.documents.forEach { element in
                let data = element.data()
                if
                    let idString = data[Constants.id] as? String,
                    let dateTimestamp = data[Constants.date] as? Timestamp,
                    let merchant = data[Constants.merchant] as? String,
                    let amount = data[Constants.amount] as? Double,
                    let typeString = data[Constants.type] as? String,
                    let categoryTypeString = data [Constants.categoryType] as? String,
                    let title = data[Constants.title] as? String,
                    let id = UUID(uuidString: idString),
                    let type = TransactionType(rawValue: typeString),
                    let categoryType = CategoryType(rawValue: categoryTypeString) 
                {
                    let date = dateTimestamp.dateValue()
                    let newTransaction = Transaction(
                        id: id,
                        date: date,
                        merchant: merchant,
                        amount: amount,
                        type: type,
                        title: title,
                        categoryType: categoryType
                    )
                    transactions.append(newTransaction)
                }
            }
            print(transactions.count)
            return transactions
        } catch {
            // Some error handling
            // This is not error handling
            print("Was not able to load transactions!")
            return transactions
        }
    }
}
