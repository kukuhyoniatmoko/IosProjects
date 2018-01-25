//
//  ItemStore.swift
//  Homepwner
//
//  Created by Kukuh Yoniatmoko on 24/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//

import Foundation

class ItemStore {
    private let factory = ItemFactory()
    
    private var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let item = factory.createItem()
        allItems.append(item)
        return item
    }
    
    func getAll() -> [Item] {
        return allItems
    }
    
    func get(index: Int) -> Item {
        return allItems[index]
    }
    
    func count() -> Int {
        return allItems.count
    }
    
    
    private class ItemFactory {
        
        let adjectives = ["Fuffy", "Rusty", "Shiny"]
        let nouns = ["Bear", "Spork", "Mac"]
        
        func createItem() -> Item {
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            let randomName = "\(randomAdjective) \(randomNoun)"
            
            let randomValue = Int(arc4random_uniform(100))
            
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            return Item(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
        }
    }
}
