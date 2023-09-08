//
//  Extensions.swift
//  SavvySaving
//
//  Created by Omar Petričević on 08.07.2023..
//

import SwiftUI

extension String{
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericEU.date(from: self) else { return Date() } // Guard u slucaju faila
        
        return parsedDate
    }
}
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Color{
    static let background = Color("Background")
    static let text = Color("Text")
    static let systemBackgroun = Color(uiColor: .systemBackground)
    static let viewOrange = Color("ViewOrange")
    static let viewOrange1 = Color("ViewOrange1")
    static let expenseColor = Color("ExpenseColor")
    static let icon = Color("Icon")
    static let shadow = Color("Shadow")
}


