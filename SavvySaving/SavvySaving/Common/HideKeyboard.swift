//
//  HideKeyboard.swift
//  SavvySaving
//
//  Created by Omar Petričević on 10.07.2023..
//

import Foundation
import UIKit

func hideKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
