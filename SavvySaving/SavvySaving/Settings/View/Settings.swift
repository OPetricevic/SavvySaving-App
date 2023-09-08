//
//  Settings.swift
//  SavvySaving
//
//  Created by Omar Petričević on 05.07.2023..
//

import SwiftUI


struct Settings: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                List {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .listRowBackground(Color.background)
                    
                    Button(action: {
                        showingAlert = true
                    }) {
                        Text("Erase Data")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .listRowBackground(Color.background)
                }
                .listStyle(PlainListStyle())
                .listRowInsets(EdgeInsets())
            }
            .padding()
            .navigationTitle("Settings")
            .background(Color.background)
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Delete Data"),
                    message: Text("Are you sure you want to delete all data?"),
                    primaryButton: .destructive(Text("Yes")) {
                        viewModel.deleteAllDocumentsInCollection { error in
                            if let error = error {
                                print("Error Deleting documents \(error)")
                            } else {
                                print("All Deleted")
                            }
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
