//
//  TotalBalanceView.swift
//  SavvySaving
//
//  Created by Omar Petričević on 09.07.2023..
//

import SwiftUI

struct TotalBalanceView: View {
    @Binding var totalBalance: Double

    var body: some View {
            VStack{
                Text("Total Balance:")
                    .font(.subheadline)
                    .foregroundColor(.text)
                
                Text("\(totalBalance, specifier: "%.2f")")
                    .font(.callout)
                    .bold()
                    .foregroundColor(.text)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.viewOrange)
            .cornerRadius(10)
            .shadow(color: .shadow, radius: 5)
        }
}

struct TotalBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        TotalBalanceView(totalBalance: .constant(1000))
    }
}

