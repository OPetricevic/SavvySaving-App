//
//  DateExtension.swift
//  SavvySaving
//
//  Created by Omar Petričević on 09.07.2023..
//

import Foundation

extension DateFormatter {
    static let allNumericEU: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        return formatter
    }()
}
