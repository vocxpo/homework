//
//  DetailViewController.swift
//  NewsDemo
//
//  Created by dev on 2018/03/03.
//  Copyright © 2018年 oopx. All rights reserved.
//

import WebKit
import UIKit

class DetailViewController: UIViewController {
    
    var urlString: String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = urlString,
            let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
    
}
