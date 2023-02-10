//
//  Card.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

/// The card from the Flutter Method Channel
struct Card {
    /// `pan token` numeration for the card (****-****-****-0000)
    let panToken: String
    /// Last four digits of the `pan token` numeration for the card (****-****-****-0000)
    let panTokenSuffix: String
    /// Holder for the card
    let holder: String
}
