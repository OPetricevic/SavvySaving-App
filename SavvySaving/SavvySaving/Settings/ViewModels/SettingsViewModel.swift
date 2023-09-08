//
//  SettingsViewModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 13.08.2023..
//

import Foundation
import Firebase
import FirebaseFirestore

class SettingsViewModel: ObservableObject {
    func deleteAllDocumentsInCollection(completion: @escaping (Error?) -> Void) {
        let database = Firestore.firestore()
        let collectionRef = database.collection(Constants.collectionName)

        collectionRef.getDocuments { querySnapshot, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                completion(nil) // Nothing to delete
                return
            }
            
            let group = DispatchGroup()
            var deletionErrors: [Error] = []
            
            for document in documents {
                group.enter()
                document.reference.delete { error in
                    if let error = error {
                        deletionErrors.append(error)
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                if deletionErrors.isEmpty {
                    completion(nil) // All documents deleted successfully
                } else {
                    completion(deletionErrors.first)
                }
            }
        }
    }
}
