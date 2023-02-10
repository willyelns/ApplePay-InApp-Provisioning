//
//  ContentView.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var walletConfiguration: AppleWalletConfiguration = AppleWalletConfiguration(description: "description", card: Card(panToken: "**** **** **** 4322", panTokenSuffix: "4322", holderName: "Willylens Xavier", primaryAccountIdentifier: "UUID"))
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!").padding()
            PassKitViewControllerRepresentable(walletConfiguration: self.$walletConfiguration)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
