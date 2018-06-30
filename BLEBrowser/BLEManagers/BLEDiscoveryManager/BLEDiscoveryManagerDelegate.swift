//
//  BLEDiscoveryManagerDelegate.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 21.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BLEDiscoveryManagerDelegate: class {
    func didDiscover(peripheral: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber)
    func didUpdateState(newState: CBManagerState)
}
