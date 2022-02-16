//
//  ViewModel.swift
//  Navigation
//
//  Created by m1 on 09/02/2022.
//

import Foundation


class RentalViewModel : RentalObserver, ObservableObject {
    
    public var rentalModel = Rental()
    
    
    @Published public var firstname : String
    @Published public var lastname : String
    @Published public var nbMachines : Int
    @Published public var type : MacModel
    @Published public var memory : Int
    @Published public var duration : Int
    @Published public var unitPrice : Double
    @Published public var totalPrice : Double
    
    @Published public var rentalState : RentalIntent = .ready {
        didSet {
            switch(self.rentalState) {
                
            //Changing values
            case .changingFirstName(let firstname) :
                self.rentalModel.firstname = firstname
                if(self.rentalModel.firstname != firstname){
                    self.rentalState = .changingFirstnameError(.tooShortName(firstname))
                }
            case .changingLastName(let lastname) :
                self.rentalModel.lastname = lastname
                if(self.rentalModel.lastname != lastname){
                    self.rentalState = .changingLastnameError(.tooShortName(lastname))
                }
            case .changingNbMachines(let nbMachines) :
                self.rentalModel.nbMachines = nbMachines
                self.unitPrice = self.rentalModel.unitPrice
                self.totalPrice = self.rentalModel.totalPrice
                if(self.rentalModel.nbMachines != nbMachines){
                    self.rentalState = .changingNbMachinesError(.illegalNegativeValue(nbMachines))
                }
            case .changingType(let type) :
                self.rentalModel.type = type
                self.unitPrice = self.rentalModel.unitPrice
                self.totalPrice = self.rentalModel.totalPrice
                if(self.rentalModel.type != type){
                    self.rentalState = .changingTypeError(.illegalValue("\(type)"))
                }
            case .changingMemory(let memory) :
                self.rentalModel.memory = memory
                self.unitPrice = self.rentalModel.unitPrice
                self.totalPrice = self.rentalModel.totalPrice
                if(self.rentalModel.memory != memory){
                    self.rentalState = .changingMemoryError(.notAPowerOfTwo(memory))
                }
            case .changingDuration(let duration) :
                self.rentalModel.duration = duration
                self.unitPrice = self.rentalModel.unitPrice
                self.totalPrice = self.rentalModel.totalPrice
                if(self.rentalModel.duration != duration){
                    self.rentalState = .changingDurationError(.tooShortDuration(duration))
                }
            
            //Values changed
            case .firstnameChanged(_) :
                break
            case .lastnameChanged(_) :
                break
            case .nbMachinesChanged(_) :
                break
            case .typeChanged(_) :
                break
            case .memoryChanged(_) :
                break
            case .durationChanged(_) :
                break
            
            //Errors
            case .changingFirstnameError(_) :
                self.firstname = self.rentalModel.firstname
            case .changingLastnameError(_) :
                self.lastname = self.rentalModel.lastname
            case .changingNbMachinesError(_) :
                self.nbMachines = self.rentalModel.nbMachines
            case .changingTypeError(_) :
                self.type = self.rentalModel.type
            case .changingMemoryError(_) :
                self.memory = self.rentalModel.memory
            case .changingDurationError(_) :
                self.duration = self.rentalModel.duration
             
            default :
                break
            }
        }
    }
    
    init(rentalModel : Rental){
        self.rentalModel = rentalModel
        
        self.firstname = rentalModel.firstname
        self.lastname = rentalModel.lastname
        self.nbMachines = rentalModel.nbMachines
        self.type = rentalModel.type
        self.memory = rentalModel.memory
        self.duration = rentalModel.duration
        self.unitPrice = rentalModel.unitPrice
        self.totalPrice = rentalModel.totalPrice
        
        self.rentalModel.observer = self
        
    }
    
    
    func changed(firstname: String) {
        self.firstname = firstname
        self.rentalState = .firstnameChanged(firstname)
    }
    
    func changed(lastname: String) {
        self.lastname = lastname
        self.rentalState = .lastnameChanged(lastname)
    }
    
    func changed(nbMachines: Int) {
        self.nbMachines = nbMachines
        self.rentalState = .nbMachinesChanged(nbMachines)
    }
    
    func changed(type: MacModel) {
        self.type = type
        self.rentalState = .typeChanged(type)
    }
    
    func changed(memory: Int) {
        self.memory = memory
        self.rentalState = .memoryChanged(memory)
    }
    
    func changed(duration: Int) {
        self.duration = duration
        self.rentalState = .durationChanged(duration)
    }
}
