//
//  InAppPassKitRepository.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

protocol InAppPassKitRepository {
  
  /**
   Return `true` if PKPassLibrary is currently accesible
  */
  func isPassKitAvailable() -> Bool
  
  /**
   Return all stored passes as PassKitItem
   */
  func passes() -> [PassKitItem]
  
  /**
   Return all stored passes linked with paired devices (AppleWatch) as PassKitItem
  */
  func remotePasses() -> [PassKitItem]
}
