//
//  MacModel.swift
//  Navigation
//
//  Created by m1 on 08/02/2022.
//

import Foundation

enum MacModel : String,Equatable, CaseIterable, Identifiable {
    var id: Self {self}
    
    case mini = "Macbook mini"
    case M1 = "Macbook mini M1"
    case Pro = "Macbook Pro"
}
