//
//  AutosizingWrapper.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation
import UIKit

@propertyWrapper
struct UsesAutoLayout<T: UIView> {
    
    init(wrappedValue: T ) {
        self.wrappedValue = wrappedValue
        
        self.configureAutoLayout()
    }
    
    var wrappedValue: T {
        didSet {
            self.configureAutoLayout()
        }
    }

    /**
    Sets the `Autoresizing` to false when the `UIView`
     */
    private func configureAutoLayout() {
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
