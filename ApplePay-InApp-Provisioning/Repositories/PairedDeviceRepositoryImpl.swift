//
//  PairedDeviceRepositoryImpl.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation
import WatchConnectivity

class PairedDeviceRepositoryImpl: PairedDeviceRepository {
    /// Use this helper to verify the Apple Watch  passes
    func hasPairedWatchDevices() -> Bool {
        guard WCSession.isSupported() else { return false }
        let session = WCSession.default
        return session.isPaired
    }
}
