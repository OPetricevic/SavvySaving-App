//
//  TotalBalanceViewModel.swift
//  SavvySaving
//
//  Created by Omar Petričević on 20.07.23.
//

import Foundation

final class TotalBalanceViewModel: ObservableObject {
    @Published var totalBalance: Double

    init(totalBalance: Double) {
        self.totalBalance = totalBalance
    }
}
