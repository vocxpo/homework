//
//  DetailViewController.swift
//  Lesson04
//
//  Created by 呉翰 on 2019/11/19.
//  Copyright © 2019 呉翰. All rights reserved.
//

import SnapKit
import UIKit
import WebKit

class DetailViewController: UIViewController {

    var urlString: String?
    var detailWebView: WKWebView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        detailWebView = WKWebView(frame: .zero)
        // super.init() should be the last call in init()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(detailWebView!)
        
        detailWebView!.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(
            item: detailWebView!,
            attribute: .left,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .left,
            multiplier: 1,
            constant: 0)
        
        let rightConstraint = NSLayoutConstraint(
            item: detailWebView!,
            attribute: .right,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .right,
            multiplier: 1,
            constant: 0)
        
        let topConstraint = NSLayoutConstraint(
            item: detailWebView!,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: detailWebView!,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0)
        
        self.view.addConstraint(leftConstraint)
        self.view.addConstraint(rightConstraint)
        self.view.addConstraint(topConstraint)
        self.view.addConstraint(bottomConstraint)

//        detailWebView!.snp.makeConstraints { (con) in
//            con.edges.equalToSuperview()
//        }

        if let urlString = urlString,
            let url = URL(string: urlString) {
            detailWebView!.load(URLRequest(url: url))
        }
    }
    
}
