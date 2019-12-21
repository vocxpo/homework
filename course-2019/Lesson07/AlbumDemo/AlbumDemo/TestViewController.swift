//
//  TestViewController.swift
//  AlbumDemo
//
//  Created by 呉翰 on 2019/12/11.
//  Copyright © 2019 呉翰. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UIScrollViewDelegate {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView = UIScrollView()
        imageView = UIImageView()
        
//        view.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        scrollView.isScrollEnabled = true
//        scrollView.zoomScale = 1
//        scrollView.contentSize = view.bounds.size
//        scrollView.delegate = self
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.backgroundColor = .white

        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cover1")
        scrollView.delegate = self
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {

        return imageView
    }

}
