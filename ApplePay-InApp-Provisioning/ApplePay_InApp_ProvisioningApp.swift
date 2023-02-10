//
//  ApplePay_InApp_ProvisioningApp.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import SwiftUI
import PassKit

@main
struct ApplePay_InApp_ProvisioningApp: App {
    var body: some Scene {
        let injector = DependencyInjector.shared
        
        /// registering PassKit repositories
        injector.register(interface: PKPassLibrary.self, service: PKPassLibrary())
        injector.register(
            interface: InAppPassKitRepository.self, service: InAppPassKitRepositoryImpl(pkPassLibrary: injector.resolve())
        )
        injector.register(interface: PairedDeviceRepository.self, service: PairedDeviceRepositoryImpl())
        return WindowGroup {
            ContentView()
        }
    }
    
}
