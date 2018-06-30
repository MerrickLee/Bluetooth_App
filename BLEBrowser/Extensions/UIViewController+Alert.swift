//
//  UIViewController+Alert.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 22.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }
}
