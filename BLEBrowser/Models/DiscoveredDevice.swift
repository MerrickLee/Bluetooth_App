//
//  DiscoveredDevice.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 21.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation
import CoreBluetooth

class DiscoveredDevice {
    let peripheral:        CBPeripheral
    let advertisementData: [String : Any]
    var rssi:              NSNumber

    init(peripheral: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber) {
        self.peripheral = peripheral
        self.advertisementData = advertisementData
        self.rssi = rssi
    }

    func getName() -> String {
        var name = "Not available"
        if let advName = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            name = advName
        } else {
            if nil != peripheral.name && !peripheral.name!.isEmpty {
                name = peripheral.name!
            }
        }
        return name
    }
    
    func isConnectable() -> Bool {
        var isConnectable = false
        if let advertismentIsConnectable = advertisementData[CBAdvertisementDataIsConnectable] as? Bool {
            isConnectable = advertismentIsConnectable
        }
        return isConnectable
    }
}
