//
//  IntExtension.swift
//  Navigation
//
//  Created by m1 on 09/02/2022.
//

import Foundation

extension Int {
    
    var isPowerOf2 : Bool {
        return (self>0) && ((self & (self-1)) == 0)
    }
    
}
