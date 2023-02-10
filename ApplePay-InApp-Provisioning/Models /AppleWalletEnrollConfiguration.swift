//
//  AppleWalletEnrollConfiguration.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

struct AppleWalletConfiguration {
    /// A text to describe the current card to be added on the Wallet
    let description: String
    /// The `Card` to be added on the Wallet.
    let card: Card
}
