//
//  PassKitItem.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

/**
  Create a new Struct to use only the necessary info about the `PKPass`
 */
struct PassKitItem {
    let cardSuffix: String
    let primaryAccountIdentifier: String
    let deviceAccountIdentifier: String
}
