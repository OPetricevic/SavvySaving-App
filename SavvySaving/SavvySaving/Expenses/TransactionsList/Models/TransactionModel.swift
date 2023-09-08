//
//  TransactionModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 08.07.2023..
//

import Foundation
import SwiftUI

struct Transaction: Identifiable, Codable, Hashable {
    let id: UUID
    let date: Date
    let merchant: String
    let amount: Double
    let type: TransactionType
    let title: String
    let categoryType: CategoryType

    var signedAmount: Double{
        return type == .expense ? -amount : amount
    }
    
    var month: String{
        date.formatted(Date.FormatStyle().year(.twoDigits).month(.wide))
    }
}

enum TransactionType: String, Codable {
    case income = "Income"
    case expense = "Expense"
}

enum CategoryType: String, Codable {
    case rent = "house.circle"
    case autoTransport = "car.fill"
    case billsUtilities = "spigot"
    case food = "fork.knife.circle"
    case healthcareInsurance = "cross.case.fill"
    case hygiene = "hands.sparkles.fill"
    case entertainment = "popcorn"
    case savings = "banknote"
    case paycheck = "eurosign"
    case other = "cart.badge.questionmark"
}


