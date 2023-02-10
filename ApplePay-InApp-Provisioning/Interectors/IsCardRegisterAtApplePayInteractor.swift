//
//  IsCardRegisterAtApplePayInteractor.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

protocol IsCardRegisterAtApplePayInteractor {
     /**
     Return true if the card is currently registed at ApplePay, false othewise
     - Note: The card is registered at ApplePay if is currently enroll in
     all available paired device (iPhone/AppleWatch) linked with the device
     */
    func execute(card: Card) -> Bool
}
