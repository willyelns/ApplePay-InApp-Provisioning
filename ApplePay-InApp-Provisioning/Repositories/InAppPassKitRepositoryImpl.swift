//
//  InAppPassKitRepositoryImpl.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation
import PassKit

class InAppPassKitRepositoryImpl: InAppPassKitRepository {
    
    private let pkPassLibrary: PKPassLibrary
    
    init(pkPassLibrary: PKPassLibrary) {
        self.pkPassLibrary = pkPassLibrary
    }
    
    func isPassKitAvailable() -> Bool {
        return PKPassLibrary.isPassLibraryAvailable()
    }

    func passes() -> [PassKitItem] {
        /// Verify again the availability of the PassKit to garantee the next API call
        guard self.isPassKitAvailable() else { return [] }

        /// Filter the PKPass from the `passes()` to a more simplier Structure
        let pkPassList: [PKPass] = self.passes()
        return pkPassList.compactMap(map(pkpass:))
    }

    func remotePasses() -> [PassKitItem] {
        /// Verify again the availability of the PassKit to garantee the next API call
        guard self.isPassKitAvailable() else { return [] }
      
        /// Filter the PKPass from the `remotePasses()` to a more simplier Structure
        let pkPassList: [PKPass] = self.remotePasses()
        return pkPassList.compactMap(map(pkpass:))
    }
  
    /**
    Return the secureItems stored into PKPassLibrary
    */
    private func passes() -> [PKPass] {
        /// Verify and return only the "Bank Card type" passes
        if #available(iOS 13.4, *) {
            return self.pkPassLibrary.passes(of: .secureElement)
        }
        return self.pkPassLibrary.passes(of: .payment)
    }

    /**
    Return the secureItems for paired devices stored into PKPassLibrary
    - Note: This should be used to return the Apple Watch passes
    */
    private func remotePasses() -> [PKPass] {
        return self.pkPassLibrary.remotePaymentPasses()
    }

    /**
    Return the suffix (****-****-****-XXXX) of the pkpass item (if its
    represents a card)
    */
    private func deviceCardSuffix(for pass: PKPass) -> String? {
        if #available(iOS 13.4, *) {
            return pass.secureElementPass?.primaryAccountNumberSuffix
        }
        return pass.paymentPass?.primaryAccountNumberSuffix
    }
    
    /**
     Return the suffix `primaryAccountIdentifier` of the pkpass item (if its
     represents a card)
    */
    private func deviceCardPrimaryAccountIdentifier(for pass: PKPass) -> String? {
        if #available(iOS 13.4, *) {
            return pass.secureElementPass?.primaryAccountIdentifier
        }
        return pass.paymentPass?.primaryAccountIdentifier
    }
  
    /**
    Return the device account identifier related with the transaction of
    the PKPass item (if exists)
    */
    private func deviceAccountIdentifier(for pass: PKPass) -> String? {
        if #available(iOS 13.4, *) {
            return pass.secureElementPass?.deviceAccountIdentifier
        }
        return pass.paymentPass?.deviceAccountIdentifier
    }
  
    /**
    Map PKPass to PassKitItem (if possible)
    */
    private func map(pkpass: PKPass) -> PassKitItem? {
        guard let deviceAccountIdentifier = self.deviceAccountIdentifier(for: pkpass) else { return nil }
        guard let deviceCardPrimaryAccountIdentifier = self.deviceCardPrimaryAccountIdentifier(for: pkpass) else {return nil}
        guard let deviceCardSuffix = self.deviceCardSuffix(for: pkpass) else { return nil }
        
        return PassKitItem(cardSuffix: deviceCardSuffix, primaryAccountIdentifier: deviceCardPrimaryAccountIdentifier, deviceAccountIdentifier: deviceAccountIdentifier)
    }
}
