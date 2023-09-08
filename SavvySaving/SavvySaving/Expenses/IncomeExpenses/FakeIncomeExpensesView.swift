//
//  FakeIncomeExpensesView.swift
//  SavvySaving
//
//  Created by Omar Petričević on 22.07.2023..
//

import SwiftUI

import SwiftUI

struct FakeIncomeExpensesView: View {
    @Binding var totalIncome: Double
    @Binding var totalExpenses: Double

    var body: some View {
            HStack(spacing: 16) {
                VStack {
                    Text("Total Income")
                        .font(.subheadline)
                        .foregroundColor(.text)
                    
                    Text("\(totalIncome, specifier: "%.2f")")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.text)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.viewOrange)
                .cornerRadius(10)
                .shadow(color: .shadow, radius: 5)
                
                VStack {
                    Text("Total Expenses")
                        .font(.subheadline)
                        .foregroundColor(.text)
                    
                    Text("\(totalExpenses, specifier: "%.2f")")                     .font(.callout)
                        .bold()
                        .foregroundColor(.text)
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.viewOrange)
                .cornerRadius(10)
                .shadow(color: .shadow, radius: 5)
//                .background(
//                    LinearGradient(gradient: Gradient(colors: [.viewOrange, .viewOrange1]), startPoint: .leading, endPoint: .trailing))
            }
            
    }
}

struct FakeIncomeExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        FakeIncomeExpensesView(totalIncome: .constant(1000),
                               totalExpenses: .constant(1000))
    }
}
