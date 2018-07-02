//
//  UpdateController.swift
//  BLEBrowser
//
//  Created by Merrick Lee on 7/1/18.
//  Copyright © 2018 zirteam. All rights reserved.
//

import UIKit
import CoreBluetooth

class UpdateController: UIViewController {
    
    var device: DiscoveredDevice!
    fileprivate var connectManager: BLEConnectManager!
    
    // MARK: - Outlets
    
    @IBOutlet weak var UpdateView: UIView!
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var submitButton: UIButton!
   
    // MARK: - Properties
    
    var deviceName: String!
    var serviceName: String!
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    // MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  print("tapped")
        
        let key =  isKeyPresentInUserDefaults(key: device.peripheral.identifier.uuidString)
        print(key)
        
        if (key == true){
            
            titleText.text = UserDefaults.standard.string(forKey: device.peripheral.identifier.uuidString)
            
        } else {
            titleText.text = device.getName()
        }
        
         print(device.getName())
         print(device.peripheral.identifier)
      
      
    }
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        print("tapped")
        
        if titleText.text?.isEmpty ?? true {
           // print("textField is empty")
            
            let alert = UIAlertController(title: "Where's the text?", message: "You can't update a device to blank", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
         
            
            self.present(alert, animated: true)
        } else {
          //  print("textField has some text")
            
             UserDefaults.standard.setValue(titleText.text, forKey: device.peripheral.identifier.uuidString)
            
           // ScanListController().refresh()
            
             UserDefaults.standard.setValue("yes", forKey: "needsRefresh")
            
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        
    }
}




