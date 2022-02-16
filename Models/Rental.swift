//
//  Rental.swift
//  Navigation
//
//  Created by m1 on 08/02/2022.
//

import Foundation


protocol RentalObserver {
    func changed(firstname : String)
    func changed(lastname : String)
    func changed(nbMachines : Int)
    func changed(type : MacModel)
    func changed(memory : Int)
    func changed(duration : Int)
}

class Rental : ObservableObject {
    
    public var observer : RentalObserver?
    
    public var firstname : String {
        didSet {
            if(self.firstname.count < 1){
                self.firstname = oldValue
            }
            else {
                self.observer?.changed(firstname: self.firstname)
            }
        }
    }
    
    public var lastname : String {
        didSet {
            if(self.lastname.count < 1){
                self.lastname = oldValue
            }
            else {
                self.observer?.changed(lastname: self.lastname)
            }
        }
    }
    
    public var nbMachines : Int {
        didSet {
            print("model.nbMachines=\(self.nbMachines)")
            if(self.nbMachines < 0){
                self.nbMachines = oldValue
            }
            else {
                self.observer?.changed(nbMachines: self.nbMachines)
            }
        }
    }
    
    public var type : MacModel {
        didSet {
            self.observer?.changed(type: self.type)
        }
    }
    
    public var memory : Int {
        didSet {
            if(!self.memory.isPowerOf2){
                self.memory = oldValue
            }
            else {
                self.observer?.changed(memory: self.memory)
            }
        }
    }
    
    public var duration : Int {
        didSet {
            if(self.duration < 24){
                self.duration = oldValue
            }
            else {
                self.observer?.changed(duration: self.duration)
            }
        }
    }
    
    public var unitPrice : Double {
        get {
            let memorySelectedPrice = memoryPrice(val: self.memory)
            let typeSelected = self.type
            let durationSelected = self.duration
            switch(typeSelected){
            case MacModel.mini :
                return 0.1*Double(durationSelected)+memorySelectedPrice
            case MacModel.M1 :
                return 0.2*Double(durationSelected)+memorySelectedPrice
            case MacModel.Pro :
                return 0.5*Double(durationSelected)+memorySelectedPrice
            }
        }
    }
    
    public var totalPrice : Double {
        get {
            return self.unitPrice * Double(self.nbMachines)
        }
    }
    
    init(
        firstname:String = "Quentin",
        lastname:String = "Desbrousses",
        nbMachines:Int = 1,
        type:MacModel = MacModel.mini,
        memory:Int = 2,
        duration:Int = 24
    ){
        self.firstname = firstname
        self.lastname = lastname
        self.nbMachines = nbMachines
        self.type = type
        self.memory = memory.isPowerOf2 ? memory : 2
        self.duration = duration
    }
    
    func memoryPrice(val : Int) -> Double{
        if(val == 2){
            return 0.02
        }
        else {
            return 0.02 + memoryPrice(val: val/2)
        }
    }
}



