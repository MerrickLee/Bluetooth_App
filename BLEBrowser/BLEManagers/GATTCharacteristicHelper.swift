//
//  GATTCharacteristicNameHelper.swift
//  BLEBrowser
//
//  Created by Max Sovalov on 22.04.2018.
//  Copyright © 2018 zirteam. All rights reserved.
//

import Foundation
import CoreBluetooth

enum GATTCharacteristicDataType {
    case string
    case uint8
    case unknown
}

struct GATTStandartCharacteristic {
    let identifier: String
    let name: String
    let type: GATTCharacteristicDataType
    
    func getReadableValue(_ data: Data?) -> String {
        if nil == data {
            return "No value data"
        }
        switch type {
        case .string:
            if let value = String(bytes: data!, encoding: String.Encoding.utf8) {
                return value
            }
            return "Type String. Can't convert fata to string. Data length (bytes): \(data!.count)."
        case .uint8:
            if data!.count != 1 {
                return "Type Int8. Unexpected data length (bytes): \(data!.count)."
            }
            let value: UInt8 = data!.bytes.first!
            return "Value: \(value)"
        case .unknown:
            return "Unknown value data type. Data length (bytes): \(data!.count)."
        }
    }
}

var standartGATTCharacteristic: [GATTStandartCharacteristic] {
    get {
        return [
            GATTStandartCharacteristic(identifier: "2A7E", name: "Aerobic Heart Rate Lower Limit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A84", name: "Aerobic Heart Rate Upper Limit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A7F", name: "Aerobic Threshold", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A80", name: "Age", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A5A", name: "Aggregate", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A43", name: "Alert Category ID", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A42", name: "Alert Category ID Bit Mask", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A06", name: "Alert Level", type: .uint8),
            GATTStandartCharacteristic(identifier: "2A44", name: "Alert Notification Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A3F", name: "Alert Status", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB3", name: "Altitude", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A81", name: "Anaerobic Heart Rate Lower Limit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A82", name: "Anaerobic Heart Rate Upper Limit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A83", name: "Anaerobic Threshold", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A58", name: "Analog", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A59", name: "Analog Output", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A73", name: "Apparent Wind Direction", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A72", name: "Apparent Wind Speed", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A01", name: "Appearance", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA3", name: "Barometric Pressure Trend", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A19", name: "Battery Level", type: .uint8),
            GATTStandartCharacteristic(identifier: "2A1B", name: "Battery Level State", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A1A", name: "Battery Power State", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A49", name: "Blood Pressure Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A35", name: "Blood Pressure Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A9B", name: "Body Composition Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A9C", name: "Body Composition Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A38", name: "Body Sensor Location", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA4", name: "Bond Management Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA5", name: "Bond Management Features", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A22", name: "Boot Keyboard Input Report", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A32", name: "Boot Keyboard Output Report", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A33", name: "Boot Mouse Input Report", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA6", name: "Central Address Resolution", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA8", name: "CGM Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA7", name: "CGM Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AAB", name: "CGM Session Run Time", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AAA", name: "CGM Session Start Time", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AAC", name: "CGM Specific Ops Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA9", name: "CGM Status", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ACE", name: "Cross Trainer Data", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A5C", name: "CSC Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A5B", name: "CSC Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A2B", name: "Current Time", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A66", name: "Cycling Power Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A65", name: "Cycling Power Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A63", name: "Cycling Power Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A64", name: "Cycling Power Vector", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A99", name: "Database Change Increment", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A85", name: "Date of Birth", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A86", name: "Date of Threshold Assessment", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A08", name: "Date Time", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A0A", name: "Day Date Time", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A09", name: "Day of Week", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A7D", name: "Descriptor Value Changed", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A00", name: "Device Name", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A7B", name: "Dew Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A56", name: "Digital", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A57", name: "Digital Output", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A0D", name: "DST Offset", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A6C", name: "Elevation", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A87", name: "Email Address", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A0B", name: "Exact Time 100", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A0C", name: "Exact Time 256", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A88", name: "Fat Burn Heart Rate Lower Limit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A89", name: "Fat Burn Heart Rate Upper Limit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A26", name: "Firmware Revision String", type: .string),
            GATTStandartCharacteristic(identifier: "2A8A", name: "First Name", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD9", name: "Fitness Machine Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ACC", name: "Fitness Machine Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ADA", name: "Fitness Machine Status", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A8B", name: "Five Zone Heart Rate Limits", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB2", name: "Floor Number", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A8C", name: "Gender", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A51", name: "Glucose Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A18", name: "Glucose Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A34", name: "Glucose Measurement Context", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A74", name: "Gust Factor", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A27", name: "Hardware Revision String", type: .string),
            GATTStandartCharacteristic(identifier: "2A39", name: "Heart Rate Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A8D", name: "Heart Rate Max", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A37", name: "Heart Rate Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A7A", name: "Heat Index", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A8E", name: "Height", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A4C", name: "HID Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A4A", name: "HID Information", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A8F", name: "Hip Circumference", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ABA", name: "HTTP Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB9", name: "HTTP Entity Body", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB7", name: "HTTP Headers", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB8", name: "HTTP Status Code", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ABB", name: "HTTPS Security", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A6F", name: "Humidity", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A2A", name: "IEEE 11073-20601 Regulatory Certification Data List", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD2", name: "Indoor Bike Data", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AAD", name: "Indoor Positioning Configuration", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A36", name: "Intermediate Cuff Pressure", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A1E", name: "Intermediate Temperature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A77", name: "Irradiance", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA2", name: "Language", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A90", name: "Last Name", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AAE", name: "Latitude", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A6B", name: "LN Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A6A", name: "LN Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB1", name: "Local East Coordinate", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB0", name: "Local North Coordinate", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A0F", name: "Local Time Information", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A67", name: "Location and Speed Characteristic", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB5", name: "Location Name", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AAF", name: "Longitude", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A2C", name: "Magnetic Declination", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA0", name: "Magnetic Flux Density - 2D", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AA1", name: "Magnetic Flux Density - 3D", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A29", name: "Manufacturer Name String", type: .string),
            GATTStandartCharacteristic(identifier: "2A91", name: "Maximum Recommended Heart Rate", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A21", name: "Measurement Interval", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A24", name: "Model Number String", type: .string),
            GATTStandartCharacteristic(identifier: "2A68", name: "Navigation", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A3E", name: "Network Availability", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A46", name: "New Alert", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC5", name: "Object Action Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC8", name: "Object Changed", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC1", name: "Object First-Created", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC3", name: "Object ID", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC2", name: "Object Last-Modified", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC6", name: "Object List Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC7", name: "Object List Filter", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ABE", name: "Object Name", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC4", name: "Object Properties", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC0", name: "Object Size", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ABF", name: "Object Type", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ABD", name: "OTS Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A04", name: "Peripheral Preferred Connection Parameters", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A02", name: "Peripheral Privacy Flag", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A5F", name: "PLX Continuous Measurement Characteristic", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A60", name: "PLX Features", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A5E", name: "PLX Spot-Check Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A50", name: "PnP ID", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A75", name: "Pollen Concentration", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A2F", name: "Position 2D", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A30", name: "Position 3D", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A69", name: "Position Quality", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A6D", name: "Pressure", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A4E", name: "Protocol Mode", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A62", name: "Pulse Oximetry Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A78", name: "Rainfall", type: .unknown),
            GATTStandartCharacteristic(identifier: "2B1D", name: "RC Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2B1E", name: "RC Settings", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A03", name: "Reconnection Address", type: .unknown),
            GATTStandartCharacteristic(identifier: "2B1F", name: "Reconnection Configuration Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A52", name: "Record Access Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A14", name: "Reference Time Information", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A3A", name: "Removable", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A4D", name: "Report", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A4B", name: "Report Map", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AC9", name: "Resolvable Private Address Only", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A92", name: "Resting Heart Rate", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A40", name: "Ringer Control point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A41", name: "Ringer Setting", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD1", name: "Rower Data", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A54", name: "RSC Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A53", name: "RSC Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A55", name: "SC Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A4F", name: "Scan Interval Window", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A31", name: "Scan Refresh", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A3C", name: "Scientific Temperature Celsius", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A10", name: "Secondary Time Zone", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A5D", name: "Sensor Location", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A25", name: "Serial Number String", type: .string),
            GATTStandartCharacteristic(identifier: "2A05", name: "Service Changed", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A3B", name: "Service Required", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A28", name: "Software Revision String", type: .string),
            GATTStandartCharacteristic(identifier: "2A93", name: "Sport Type for Aerobic and Anaerobic Thresholds", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD0", name: "Stair Climber Data", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ACF", name: "Step Climber Data", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A3D", name: "String", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD7", name: "Supported Heart Rate Range", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD5", name: "Supported Inclination Range", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A47", name: "Supported New Alert Category", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD8", name: "Supported Power Range", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD6", name: "Supported Resistance Level Range", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD4", name: "Supported Speed Range", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A48", name: "Supported Unread Alert Category", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A23", name: "System ID", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ABC", name: "TDS Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A6E", name: "Temperature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A1F", name: "Temperature Celsius", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A20", name: "Temperature Fahrenheit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A1C", name: "Temperature Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A1D", name: "Temperature Type", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A94", name: "Three Zone Heart Rate Limits", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A12", name: "Time Accuracy", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A15", name: "Time Broadcast", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A13", name: "Time Source", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A16", name: "Time Update Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A17", name: "Time Update State", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A11", name: "Time with DST", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A0E", name: "Time Zone", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AD3", name: "Training Status", type: .unknown),
            GATTStandartCharacteristic(identifier: "2ACD", name: "Treadmill Data", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A71", name: "True Wind Direction", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A70", name: "True Wind Speed", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A95", name: "Two Zone Heart Rate Limit", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A07", name: "Tx Power Level", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB4", name: "Uncertainty", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A45", name: "Unread Alert Status", type: .unknown),
            GATTStandartCharacteristic(identifier: "2AB6", name: "URI", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A9F", name: "User Control Point", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A9A", name: "User Index", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A76", name: "UV Index", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A96", name: "VO2 Max", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A97", name: "Waist Circumference", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A98", name: "Weight", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A9D", name: "Weight Measurement", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A9E", name: "Weight Scale Feature", type: .unknown),
            GATTStandartCharacteristic(identifier: "2A79", name: "Wind Chill", type: .unknown)
        ]
    }
}

class GATTCharacteristicHelper {
    static func getStandartCharacteristic(by uuid: CBUUID) -> GATTStandartCharacteristic {
        let filteredArray = standartGATTCharacteristic.filter { (item) -> Bool in
            return uuid.uuidString == item.identifier
        }
        if filteredArray.count == 1 {
            return filteredArray.first!
        }
        return GATTStandartCharacteristic(identifier: uuid.uuidString, name: "Unknown Characteristic", type: .unknown)
    }    
}
