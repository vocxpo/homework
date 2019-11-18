//
//  DetailViewController.swift
//  Lesson04
//
//  Created by 呉翰 on 2019/11/19.
//  Copyright © 2019 呉翰. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var urlString: String?
    @IBOutlet weak var detailWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = urlString,
            let url = URL(string: urlString) {
            detailWebView.load(URLRequest(url: url))
        }
    }
    
}
