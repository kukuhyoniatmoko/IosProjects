//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Kukuh Yoniatmoko on 22/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: "https://bignerdranch.com")!))
    }
}
