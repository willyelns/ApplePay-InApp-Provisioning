//
//  AutosizingWrapper.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation
import UIKit

@propertyWrapper
struct UsesAutoLayoutWithConstraintsAndAnchor<T: UIView> {
    
    private let view: UIView
    private let topAnchorConstraintValue: CGFloat
    private let leadingAnchorConstraintValue: CGFloat
    private let trailingAnchorConstraintValue: CGFloat
    
    init(wrappedValue: T, view: UIView, topAnchorConstraintValue: CGFloat, leadingAnchorConstraintValue: CGFloat, trailingAnchorConstraintValue: CGFloat) {
        self.wrappedValue = wrappedValue
        self.view = view
        self.topAnchorConstraintValue = topAnchorConstraintValue
        self.leadingAnchorConstraintValue = leadingAnchorConstraintValue
        self.trailingAnchorConstraintValue = trailingAnchorConstraintValue
        
        self.configureAutoLayout()
        self.configureConstraints()
    }
    
    var wrappedValue: T {
        didSet {
            self.configureAutoLayout()
            self.configureAutoLayout()
        }
    }

    /**
    Sets the `Autoresizing` to false when the `UIView`
     */
    private func configureAutoLayout() {
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /**
     Sets the constraints to fit the `UIView`
     */
    private func configureConstraints() {
        self.wrappedValue.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: topAnchorConstraintValue).isActive = true
        self.wrappedValue.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.leadingAnchorConstraintValue).isActive = true
        self.wrappedValue.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: trailingAnchorConstraintValue).isActive = true
    }
}
