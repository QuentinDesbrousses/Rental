//
//  TrackUIView.swift
//  Navigation
//
//  Created by m1 on 08/02/2022.
//

import SwiftUI

struct TrackUIView: View {
    
    @StateObject private var vm = RentalViewModel(rentalModel: Rental())
    
    @State var errorMessage = "Error !"
    @State var showingAlert : Bool = false
    
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(spacing:50) {
            
            HStack(spacing:30) {
                Text("Set your machine")
            }
            HStack(spacing:60) {
                VStack(spacing:15) {
                    Text("Firstname:")
                    Text("Lastname:")
                    Text("Number of machines:")
                    Text("Type:")
                    Text("Memory:")
                    Text("Duration (in hours):")
                    Text("Unit Price:")
                    Text("Total Price:")
                }
                VStack(spacing:15) {
                    TextField("firstname",text: $vm.firstname)
                        .onSubmit {
                            vm.rentalState.intentToChange(firstname: vm.firstname)
                        }
                    TextField("lastname",text: $vm.lastname)
                        .onSubmit {
                            vm.rentalState.intentToChange(lastname:  vm.lastname)
                        }
                    Stepper("\(vm.nbMachines)", onIncrement: {
                        vm.rentalState.intentToChange(nbMachines: vm.nbMachines+1)
                    } , onDecrement: {
                        vm.rentalState.intentToChange(nbMachines: vm.nbMachines-1)
                    })
                        
                    Picker(vm.type.rawValue, selection: $vm.type){
                        ForEach(MacModel.allCases) {
                            mac in Text(mac.rawValue.capitalized).tag(mac)
                        }
                    }
                    .onSubmit {
                        self.vm.rentalState.intentToChange(type: vm.type)
                    }
                    TextField("\(vm.memory)",value: $vm.memory, formatter: formatter)
                        .onSubmit {
                            vm.rentalState.intentToChange(memory: vm.memory)
                        }
                    TextField("\(vm.duration)",value: $vm.duration, formatter: formatter)
                        .onSubmit {
                            vm.rentalState.intentToChange(duration: vm.duration)
                        }
                    Text("\(vm.unitPrice)")
                    Text("\(vm.totalPrice)")
                }
            }
            HStack {
                Text("See your settings")
            }
            HStack(spacing:30) {
                VStack(spacing:15) {
                    Text("\(vm.lastname)")
                    HStack(spacing:10) {
                        Text("\(vm.nbMachines)")
                        Text(vm.type.rawValue)
                    }
                    Text("Total Price:")
                }
                VStack(spacing:15) {
                    Text("\(vm.firstname)")
                    HStack {
                        Text("\(vm.memory)")
                        Text("Go")
                    }
                    Text("\(vm.totalPrice)")
                }
            }
        }
        .onChange(of: vm.rentalState){ state in
                  stateChanged(state: state)
               }
         .alert("\(errorMessage)", isPresented: $showingAlert){
              Button("Ok", role: .cancel){}
         }.padding()
    }
                      
                                              
    private func stateChanged(state : RentalIntent) {
        switch(state){
            //changed
        case .firstnameChanged(_), .lastnameChanged(_), .nbMachinesChanged(_), .typeChanged(_), .memoryChanged(_), .durationChanged(_):
            self.vm.rentalState.viewUpdated()
            //errors
        case .changingFirstnameError(let error), .changingLastnameError(let error), .changingNbMachinesError(let error), .changingTypeError(let error), .changingMemoryError(let error), .changingDurationError(let error):
            self.errorMessage = "\(error)"
            self.showingAlert = true
            self.vm.rentalState.viewUpdated()
            
        default :
            break
        }
    }


}

struct TrackUIView_Previews: PreviewProvider {
    static var previews: some View {
        TrackUIView()
    }
}
