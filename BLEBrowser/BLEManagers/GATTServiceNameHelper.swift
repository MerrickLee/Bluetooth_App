//
//  GATTServiceNameHelper.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 22.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation
import CoreBluetooth

class GATTServiceNameHelper {
    static func getServiceName(uuid: CBUUID) -> String {
        let uuidString = uuid.uuidString
        switch uuidString {
        case "1800":
            return "Generic Access"
        case "1811":
            return "Alert Notification Service"
        case "1815":
            return "Automation IO"
        case "180F":
            return "Battery Service"
        case "1810":
            return "Blood Pressure"
        case "181B":
            return "Body Composition"
        case "181E":
            return "Bond Management Service"
        case "181F":
            return "Continuous Glucose Monitoring"
        case "1805":
            return "Current Time Service"
        case "1818":
            return "Cycling Power"
        case "1816":
            return "Cycling Speed and Cadence"
        case "180A":
            return "Device Information"
        case "181A":
            return "Environmental Sensing"
        case "1826":
            return "Fitness Machine"
        case "1801":
            return "Generic Attribute"
        case "1808":
            return "Glucose"
        case "1809":
            return "Health Thermometer"
        case "180D":
            return "Heart Rate"
        case "1823":
            return "HTTP Proxy"
        case "1812":
            return "Human Interface Device"
        case "1802":
            return "Immediate Alert"
        case "1821":
            return "Indoor Positioning"
        case "1820":
            return "Internet Protocol Support Service"
        case "1803":
            return "Link Loss"
        case "1819":
            return "Location and Navigation"
        case "1827":
            return "Mesh Provisioning Service"
        case "1828":
            return "Mesh Proxy Service"
        case "1807":
            return " Next DST Change Service"
        case "1825":
            return "Object Transfer Service"
        case "180E":
            return "Phone Alert Status Service"
        case "1822":
            return "Pulse Oximeter Service"
        case "1829":
            return "Reconnection Configuration"
        case "1806":
            return "Reference Time Update Service"
        case "1814":
            return "Running Speed and Cadence"
        case "1813":
            return "Scan Parameters"
        case "1824":
            return "Transport Discovery"
        case "1804":
            return "Tx Power"
        case "181C":
            return "User Data"
        case "181D":
            return "Weight Scale"

        default:
            return "Unknown Service"
        }
    }
}
