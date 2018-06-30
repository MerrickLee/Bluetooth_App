//
//  ServicesController.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 21.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import UIKit
import CoreBluetooth

class ServicesController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var deviceNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var connectBtn: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadIndicatorContainer: UIView!

    // MARK: - Properties
    
    let CONNECT = "Connect"
    let DISCONNECT = "Disconnect"
    let CONNECTING = "Connecting..."
    
    var device: DiscoveredDevice!
    fileprivate var connectManager: BLEConnectManager!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        deviceNameLbl.text = "Device: \(device.getName())"
        statusLbl.text = "Status: Initialize..."
        connectManager = BLEConnectManager(deviceIdentifier: device.peripheral.identifier, delegate: self, central: nil)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CharacteristicsSegue" {
            if let destination = segue.destination as? CharacteristiscController, let characteristics = sender as? [CBCharacteristic] {
                destination.deviceName = "Device: \(self.deviceNameLbl.text!)"
                destination.serviceName = "Service: \(GATTServiceNameHelper.getServiceName(uuid: characteristics.first!.service.uuid))"
                destination.characteristics = characteristics
                destination.connectManager = self.connectManager
            }
        }
    }
    
    // MARK: - UI Actions
    
    @IBAction func connectBtnTapped(_ sender: Any) {
        if connectBtn.title == CONNECTING {
            return
        }
        if connectBtn.title == CONNECT {
            connectBtn.title = CONNECTING
        } else if connectBtn.title == DISCONNECT {
            
        }
    }
    
    // MARK: - Private methods
    
    fileprivate func showErrorMessage(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }

}

// MARK: - BLEConnectManagerDelegate implementation

extension ServicesController: BLEConnectManagerDelegate {

    func connectStatusChanged(newStatus: PeriphiralConnectedState) {
        switch newStatus {
        case .connected:
            statusLbl.text = "Status: Connected"
        case .disconnected:
            statusLbl.text = "Status: Disconnected"
        case .unknown:
            statusLbl.text = "Status: Unknown"
        }
    }

    func didConnect() {
        self.statusLbl.text = "Status: Connected"
    }

    func didFailToConnect(error: Error?) {
        self.statusLbl.text = "Status: Not connected"
        if let error = error {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    func didDisconnectPeripheral(error: Error?) {
        self.statusLbl.text = "Status: Disconnected"
        if let error = error {
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }

    func startLoading() {
        loadIndicatorContainer.isHidden = false
        loadIndicator.startAnimating()
        table.isHidden = true
    }

    func stopLoading() {
        loadIndicatorContainer.isHidden = true
        loadIndicator.stopAnimating()
        table.isHidden = false
    }

    func updateServices() {
        table.reloadData()
    }
    
    func showCharacteristics(_ characteristics: [CBCharacteristic]) {
        performSegue(withIdentifier: "CharacteristicsSegue", sender: characteristics)
    }
}

// MARK: - UITableViewDataSource implementation

extension ServicesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectManager.services.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceCell
        cell.nameLbl.text = GATTServiceNameHelper.getServiceName(uuid: connectManager.services[indexPath.row].uuid)
        cell.uuidLbl.text = "UUID: \(connectManager.services[indexPath.row].uuid.uuidString)"
        cell.primaryLbl.text = "Primary: \(connectManager.services[indexPath.row].isPrimary)"
        return cell
    }
}

// MARK: - UITableViewDelegate implementation

extension ServicesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        connectManager.readCharacteristics(serviceIndex: indexPath.row)
    }
}
