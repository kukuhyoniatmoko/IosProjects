//
//  ViewController.swift
//  Buggy
//
//  Created by Kukuh Yoniatmoko on 24/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print("buttonTapped")
        badMethod()
    }
    
    private func badMethod() {
        let array = NSMutableArray()
        
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        
        for _ in 0..<10 {
            array.removeObject(at: 0)
        }
    }
 }
