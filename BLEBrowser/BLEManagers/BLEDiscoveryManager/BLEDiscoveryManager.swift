//
//  BLEDiscoveryManager.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 22.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEDiscoveryManager: NSObject {

    // MARK: - Properties
    
    weak var delegate: BLEDiscoveryManagerDelegate?

    fileprivate let centralManager: CBCentralManager
    fileprivate let centralManagerQueue: DispatchQueue
    
    var isScanning: Bool {
        get {
            return centralManager.isScanning
        }
    }

    var state: CBManagerState {
        get {
            return centralManager.state
        }
    }
    
    /**
     Singleton of current class
     */
    static public let shared = BLEDiscoveryManager()
    
    // MARK: - Initializers
    
    private override init() {
        self.centralManagerQueue = DispatchQueue(label: "BLE Discovery Manager")
        self.centralManager = CBCentralManager(delegate: nil, queue: centralManagerQueue, options: nil)
        super.init()
        self.centralManager.delegate = self
    }

    // MARK: - Public methods
    
    func startDiscoveryAllPeripherals() {
        if centralManager.isScanning {
            return // already scaning
        } else {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }

    func stopDiscoveryAllPeripherals() {
        if centralManager.isScanning {
            centralManager.stopScan()
        }
    }
}

// MARK: - Implementation CBCentralManagerDelegate

extension BLEDiscoveryManager: CBCentralManagerDelegate {

    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        DispatchQueue.main.async {
            self.delegate?.didUpdateState(newState: central.state)
        }
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        DispatchQueue.main.async {
            self.delegate?.didDiscover(peripheral: peripheral, advertisementData: advertisementData, rssi: RSSI)
        }
    }
}
