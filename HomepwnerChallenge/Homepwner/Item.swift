//
//  Item.swift
//  Homepwner
//
//  Created by Kukuh Yoniatmoko on 24/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//
import Foundation

class Item {
    let name: String
    let valueInDollars: Int
    let serialNumber: String?
    let dateCreated: Date
    
    init(name: String, valueInDollars: Int, serialNumber: String? = nil) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
    }
}
