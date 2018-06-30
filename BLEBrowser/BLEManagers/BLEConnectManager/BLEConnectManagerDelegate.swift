//
//  BLEConnectManagerDelegate.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 21.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BLEConnectManagerDelegate: class {
    func didConnect()
    func didFailToConnect(error: Error?)
    func didDisconnectPeripheral(error: Error?)
    func connectStatusChanged(newStatus: PeriphiralConnectedState)
    func startLoading()
    func stopLoading()
    func updateServices()
    func showCharacteristics(_ characteristics: [CBCharacteristic])
}
