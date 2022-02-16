//
//  Intent.swift
//  Navigation
//
//  Created by m1 on 09/02/2022.
//

import Foundation

//errors

enum ViewModelError : Error, CustomStringConvertible, Equatable {
    
    case tooShortName(String)
    case illegalNegativeValue(Int)
    case notAPowerOfTwo(Int)
    case tooShortDuration(Int)
    case illegalValue(String)
    
    var description: String {
        switch(self){
            
        case .tooShortName(let name) :
            return "The input is too short : \(name)"
        case .illegalNegativeValue(let value) :
            return "This value must be positive : \(value)"
        case .notAPowerOfTwo(let memory) :
            return "Memory must be a power of two : \(memory) "
        case .tooShortDuration(let duration) :
            return "Duration must be greater than 24 : \(duration)"
        case .illegalValue(let error) :
            return "This value is illegal : "+error
        }
    }
}

enum RentalIntent : Equatable {
    
    //States
    
    case ready
    
    case changingFirstName(String)
    case firstnameChanged(String)
    case changingFirstnameError(ViewModelError)
    
    case changingLastName(String)
    case lastnameChanged(String)
    case changingLastnameError(ViewModelError)
    
    case changingNbMachines(Int)
    case nbMachinesChanged(Int)
    case changingNbMachinesError(ViewModelError)
    
    case changingType(MacModel)
    case typeChanged(MacModel)
    case changingTypeError(ViewModelError)
    
    case changingMemory(Int)
    case memoryChanged(Int)
    case changingMemoryError(ViewModelError)
    
    case changingDuration(Int)
    case durationChanged(Int)
    case changingDurationError(ViewModelError)
    
    //Intent
    
    mutating func intentToChange(firstname : String){
            self = .changingFirstName(firstname)
    }
    
    mutating func intentToChange(lastname : String){
            self = .changingLastName(lastname)
    }
    
    mutating func intentToChange(nbMachines : Int){
            self = .changingNbMachines(nbMachines)
    }
    
    mutating func intentToChange(type : MacModel) {
        self = .changingType(type)
    }
    
    mutating func intentToChange(memory : Int) {
            self = .changingMemory(memory)
    }
    
    mutating func intentToChange(duration : Int) {
            self = .changingDuration(duration)
    }
    
    mutating func viewUpdated(){
        self = .ready
    }
}
