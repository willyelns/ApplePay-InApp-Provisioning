//
//  IsCardRegisterAtApplePayInterectorImpl.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

class IsCardRegisterAtApplePayInteractorImpl: IsCardRegisterAtApplePayInteractor {
    
    private let pairedDeviceRepository: PairedDeviceRepository
    private let passKitRepository: InAppPassKitRepository
    
    init(pairedDeviceRepository: PairedDeviceRepository,
         passKitRepository: InAppPassKitRepository) {
        self.pairedDeviceRepository = pairedDeviceRepository
        self.passKitRepository = passKitRepository
    }
    
    func execute(card: Card) -> Bool {
        /// Check if the current card is added on the iPhone
        let isEnrollLocally = self.isEnrollLocally(card)
        /// Check if the current card is added on the Apple Watch
        let isEnrollRemotelly = self.isEnrollRemotelly(card)
        /// Check the all the devices has the card added
        return isEnrollLocally && isEnrollRemotelly
    }
    
    /**
    Return `true` if we find a card with the same suffix located into the iPhone
    */
    private func isEnrollLocally(_ card: Card) -> Bool {
        /// verify the local passes (iPhone)
        let passes = self.passKitRepository.passes()
        /// Check if the current card is added on the iPhone
        return self.isEnroll(card: card, into: passes)
    }
    
    /**
    Return `true` if we find a card with the same suffix located into the Remote devices
     - Note: Currently only the Apple Watch is supported
    */
    private func isEnrollRemotelly(_ card: Card) -> Bool {
        /// Check if has Apple Watch paired
        if self.pairedDeviceRepository.hasPairedWatchDevices() {
            /// verify the remote passes
            let remotePasses = self.passKitRepository.remotePasses()
            /// Check if the current card is added on the Watch
            return self.isEnroll(card: card, into: remotePasses)
        }
        return false
    }
      
     /**
     Return `true` if we find a card with the same suffix located into a PassKitItem
     */
    private func isEnroll(card: Card, into passes: [PassKitItem]) -> Bool {
        let referenceCardSuffix = card.panToken.suffix(4)
        return passes.first { item -> Bool in
            return item.cardSuffix == referenceCardSuffix
        } != nil
    }
}
