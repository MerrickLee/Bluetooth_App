//
//  BLEConnectManager.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 22.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation

import CoreBluetooth

enum PeriphiralConnectedState {
    case connected
    case disconnected
    case unknown
}

typealias ReadCharacteristicValueResult = (_ characteristic: CBCharacteristic, _ error: Error?) -> Void

class ConnectManagerError: Error {

    private var description: String
    var localizedDescription: String {
        get {
            return description
        }
    }

    init(description: String) {
        self.description = description
    }
}

class BLEConnectManager: NSObject {

    // MARK: - Properties
    
    fileprivate weak var delegate: BLEConnectManagerDelegate?

    fileprivate let centralManager: CBCentralManager
    fileprivate let centralManagerQueue: DispatchQueue

    fileprivate var deviceIdentifier: UUID!
    fileprivate var targetPeripheral: CBPeripheral?

    fileprivate var needToConnect = false

    private (set) var deviceConnectedState = PeriphiralConnectedState.unknown {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.connectStatusChanged(newStatus: self.deviceConnectedState)
            }
        }
    }

    private (set) var isLoading = true {
        didSet {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.delegate?.startLoading()
                } else {
                    self.delegate?.stopLoading()
                }
            }
        }
    }
    
    private (set) var services = [CBService]() {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateServices()
            }
        }
    }
    
    private var readCharacteristicValueResult: ReadCharacteristicValueResult?
    
    // MARK: - Initializers

    private override init() {
        self.centralManagerQueue = DispatchQueue(label: "BLE Connect Manager")
        self.centralManager = CBCentralManager(delegate: nil, queue: centralManagerQueue, options: nil)
        super.init()
    }
    
    init(deviceIdentifier: UUID, delegate: BLEConnectManagerDelegate?, central: CBCentralManager?) {
        self.deviceIdentifier = deviceIdentifier
        self.centralManagerQueue = DispatchQueue(label: "BLE Connect Manager")
        if nil != central {
            self.centralManager = central!
        } else {
            self.centralManager = CBCentralManager(delegate: nil, queue: centralManagerQueue, options: nil)
        }
        super.init()
        self.delegate = delegate
        self.centralManager.delegate = self
        connectToPeripheral()
    }

    // MARK: - Public methods
    
    func connectToPeripheral() {
        needToConnect = true
        isLoading = true
        if self.centralManager.state != .poweredOn {
            return // wait powerOn
        }
        needToConnect = false
        self.centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func readCharacteristics(serviceIndex: Int) {
        if deviceConnectedState != .connected || nil == targetPeripheral || nil == targetPeripheral!.services {
            self.delegate?.didFailToConnect(error: ConnectManagerError(description: "Please (re)connect to device"))
            return
        }
        if targetPeripheral!.services!.count == 0 || serviceIndex < 0 || serviceIndex >= targetPeripheral!.services!.count  {
            self.delegate?.didFailToConnect(error: ConnectManagerError(description: "You select unexpected service"))
            return
        }
        isLoading = true
        targetPeripheral?.discoverCharacteristics(nil, for: targetPeripheral!.services![serviceIndex])
    }

    func readValue(for characteristic: CBCharacteristic, callback: ReadCharacteristicValueResult?) {
        if deviceConnectedState != .connected || nil == targetPeripheral || nil == targetPeripheral!.services {
            self.delegate?.didFailToConnect(error: ConnectManagerError(description: "Please (re)connect to device"))
            return
        }
        self.readCharacteristicValueResult = callback
        targetPeripheral?.readValue(for: characteristic)
        isLoading = true
    }
}

// MARK: - Implementation CBCentralManagerDelegate

extension BLEConnectManager: CBCentralManagerDelegate {
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central == centralManager && central.state == .poweredOn && needToConnect {
            connectToPeripheral()
        }
    }

    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if deviceIdentifier.uuidString == peripheral.identifier.uuidString {
            self.centralManager.stopScan()
            self.targetPeripheral = peripheral
            self.targetPeripheral?.delegate = self
            self.centralManager.connect(self.targetPeripheral!, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if self.centralManager != central || self.targetPeripheral != peripheral {
            return
        }
        self.deviceConnectedState = .connected
        DispatchQueue.main.async {
            self.delegate?.didConnect()
        }
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        self.deviceConnectedState = .disconnected
        DispatchQueue.main.async {
            self.delegate?.didFailToConnect(error: error)
        }
        isLoading = false
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        self.deviceConnectedState = .disconnected
        DispatchQueue.main.async {
            self.delegate?.didDisconnectPeripheral(error: error)
        }
        isLoading = false
    }
}

// MARK: - Implementation CBPeripheralDelegate

extension BLEConnectManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        isLoading = false
        if nil != peripheral.services && peripheral.services!.count > 0 {
            self.services = peripheral.services!
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        isLoading = false
        if nil != error {
            DispatchQueue.main.async {
                self.delegate?.didFailToConnect(error: error)
            }
            return
        }
        if nil != service.characteristics && service.characteristics!.count > 0 {
            DispatchQueue.main.async {
                self.delegate?.showCharacteristics(service.characteristics!)
            }
        } else {
            DispatchQueue.main.async {
                self.delegate?.didFailToConnect(error: ConnectManagerError(description: "No available characteristics"))
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        isLoading = false
        DispatchQueue.main.async {
            self.readCharacteristicValueResult?(characteristic, error)
        }
    }
}









