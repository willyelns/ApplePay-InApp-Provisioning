//
//  DependencyContainer.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation


/**
 Dependency Container class to help the instances to be used
 */
class DependencyInjector {
    
    public static var shared = DependencyInjector()
    
    private var services: [String: Any] = [:]
    
    /**
     Adding services to the list
     */
    func register<T>(interface: T.Type, service: T) {
        let key = String(describing: interface)
        services[key] = service
    }
    
    /**
     Extracting services to the list
     */
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        return services[key] as! T
    }
}
