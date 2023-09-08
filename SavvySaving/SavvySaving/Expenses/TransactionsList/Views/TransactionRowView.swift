//
//  TransactionRow.swift
//  SavvySaving
//
//  Created by Omar Petričević on 08.07.2023..
//

import SwiftUI


struct TransactionRowView: View {
   @StateObject var transactionRowViewModel: TransactionRowViewModel
    
    var body: some View {
        HStack(spacing: 20){
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.background.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    Image(systemName: "\(transactionRowViewModel.transaction.categoryType.rawValue)").imageScale(.large).foregroundColor(Color.icon)
                }
            VStack(alignment: .leading, spacing: 6){
                Text(transactionRowViewModel.transaction.title)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                Text(transactionRowViewModel.transaction.merchant)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                Text(transactionRowViewModel.transactionDate)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(transactionRowViewModel.transactionSignedAmount)
                .bold()
                .foregroundColor(transactionRowViewModel.transactionTypeColor)
                .font(.callout)
                
        }.background(Color.background)
    }
}
