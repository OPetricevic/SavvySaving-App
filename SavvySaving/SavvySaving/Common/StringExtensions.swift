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
