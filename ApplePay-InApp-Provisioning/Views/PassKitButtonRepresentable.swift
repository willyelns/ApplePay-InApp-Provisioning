//
//  PassKitButtonRepresentable.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation
import UIKit
import SwiftUI
import PassKit

struct PassKitViewControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = PassKitButtonViewController
    
    @Binding var walletConfiguration: AppleWalletConfiguration
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    
    func makeUIViewController(context: Context) -> PassKitButtonViewController {
        let inAppPassKitReposiotry: InAppPassKitRepository = DependencyInjector.shared.resolve()
        let passKitButtonViewController = PassKitButtonViewController(inAppPassKitReposiotry, walletConfiguration: self.walletConfiguration)
        return passKitButtonViewController
    }
    
    func updateUIViewController(_ uiViewController: PassKitButtonViewController, context: Context) {
        
    }
}


