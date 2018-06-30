//
//  ScanListController.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 20.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import UIKit
import CoreBluetooth

class ScanListController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var scanButton: UIBarButtonItem!
    @IBOutlet weak var table: UITableView!
    
    // MARK: - Properties
    
    private let START_SCAN = "Start scan"
    private let STOP_SCAN = "Stop scan"
    

    fileprivate var discoveredDevices = [DiscoveredDevice]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanButton.title = START_SCAN
        scanButton.isEnabled = false
        BLEDiscoveryManager.shared.delegate = self
        table.dataSource = self
        table.reloadData()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ServicesSegue" {
            if let destination = segue.destination as? ServicesController, let indexPath = sender as? IndexPath {
                destination.device = discoveredDevices[indexPath.row]
            }
        }
    }

    // MARK: - UI Actions
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        if scanButton.title == START_SCAN {
            discoveredDevices = [DiscoveredDevice]()
            scanButton.title = STOP_SCAN
            table.reloadData()
            BLEDiscoveryManager.shared.startDiscoveryAllPeripherals()
        } else if scanButton.title == STOP_SCAN {
            scanButton.title = START_SCAN
            BLEDiscoveryManager.shared.stopDiscoveryAllPeripherals()
        }
    }

    // MARK: - Private methods
    
    fileprivate func deviceCantUseBluetooth() {
        scanButton.isEnabled = false
        self.showAlert(title: "Error", message: "It's impossible to use BLE on this device")
    }

    fileprivate func showSettingsAlert() {
        let alert = UIAlertController(title: "No power", message: "The bluetooth switched off. Please turn on bluetooth in Settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
            let url = URL(string: "App-Prefs:root=Bluetooth") //for bluetooth setting
            let app = UIApplication.shared
            app.open(url!, options: [String : Any](), completionHandler: nil)
        }))
        self.present(alert, animated: false, completion: nil)
    }
}


// MARK: - BLEDiscoveryManagerDelegate implementation

extension ScanListController: BLEDiscoveryManagerDelegate {
    func didUpdateState(newState: CBManagerState) {
        switch newState {
        case .unknown: // State unknown, update imminent.
            deviceCantUseBluetooth()
        case .resetting: // The connection with the system service was momentarily lost, update imminent.
            scanButton.isEnabled = false // just wait
            print("just wait")
        case .unsupported: // The platform doesn't support the Bluetooth Low Energy Central/Client role.
            deviceCantUseBluetooth()
        case .unauthorized: // The application is not authorized to use the Bluetooth Low Energy role.
            deviceCantUseBluetooth()
        case .poweredOff: // Bluetooth is currently powered off.
            scanButton.isEnabled = false
            showSettingsAlert()
        case .poweredOn: // Bluetooth is currently powered on and available to use.
            scanButton.isEnabled = true
        }
    }
    
    func didDiscover(peripheral: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber) {
        for index in 0..<self.discoveredDevices.count {
            let device = self.discoveredDevices[index]
            if device.peripheral.identifier.uuidString == peripheral.identifier.uuidString {
                device.rssi = rssi
                self.table.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
                return
            }
        }
        self.discoveredDevices.append(DiscoveredDevice(peripheral: peripheral,
                                                  advertisementData: advertisementData,
                                                  rssi: rssi))
        self.table.reloadData()
    }
}

// MARK: - UITableViewDataSource implementation

extension ScanListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredDevices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceCell
        
        if(discoveredDevices[indexPath.row].getName() == "Not available") {
            //  fatalError("Unexpected section)")
        }else {
            
            cell.nameLbl.text = discoveredDevices[indexPath.row].getName()
            cell.identifierLbl.text = discoveredDevices[indexPath.row].peripheral.identifier.uuidString
            cell.rssiLbl.text = "rssi: \(discoveredDevices[indexPath.row].rssi) dBm"
            cell.connectBtn.isHidden = !discoveredDevices[indexPath.row].isConnectable()
            
            cell.connectBtnClosure = {
                BLEDiscoveryManager.shared.stopDiscoveryAllPeripherals()
                if self.scanButton.title == self.STOP_SCAN {
                    self.scanButton.title = self.START_SCAN
                }
                self.performSegue(withIdentifier: "ServicesSegue", sender: indexPath)
            }
           
        }

       
      
        return cell
    }
}
