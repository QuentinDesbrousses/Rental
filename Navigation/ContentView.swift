//
//  ContentView.swift
//  Navigation
//
//  Created by m1 on 08/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NavigationLink(destination: TrackUIView()){
                    Text("Access to machine settings")
            }.navigationTitle("Settings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
