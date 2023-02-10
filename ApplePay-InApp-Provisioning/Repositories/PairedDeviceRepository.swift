//
//  PairedDeviceRepository.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

protocol PairedDeviceRepository {
     /**
     Return true if the device has a watch paired device linked. False othewise
     */
     func hasPairedWatchDevices() -> Bool
}
