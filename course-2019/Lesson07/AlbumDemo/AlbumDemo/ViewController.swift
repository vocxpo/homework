//
//  ViewController.swift
//  AlbumDemo
//
//  Created by 呉翰 on 2019/12/09.
//  Copyright © 2019 呉翰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var pages: [UIViewController] = {
        return [
            getViewController(at: 0),
            getViewController(at: 1),
            getViewController(at: 2),
            getViewController(at: 3),
            getViewController(at: 4),
        ]
    }()

    let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)

    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        view.addSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        pageControl.numberOfPages = 5
        pageControl.isUserInteractionEnabled = false
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 6).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        pageViewController.dataSource = self
        pageViewController.delegate = self

        if let firstVC = pages.first {
            pageViewController.setViewControllers([firstVC],
                                                  direction: .forward,
                                                  animated: false)
        }
    }

    func getViewController(at index: Int) -> AlbumImageVC {
        return AlbumImageVC(index: index)
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        return pages[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first else { return }
        guard let viewControllerIndex = pages.firstIndex(of: currentViewController) else { return }
        pageControl.currentPage = viewControllerIndex
    }
}

class AlbumImageVC: UIViewController, UIScrollViewDelegate {
    let index: Int
    let scrollView: UIScrollView
    let imageView: UIImageView
    
    var isDoubleTap: Bool = false

    init(index: Int) {
        self.index = index
        scrollView = UIScrollView()
        imageView = UIImageView()
        
        super.init(nibName: nil, bundle: nil)

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.isScrollEnabled = true
        scrollView.zoomScale = 1
        scrollView.contentSize = view.bounds.size
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white

        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "cover\(index + 1)")
        
//        // enable pinch
//        imageView.isUserInteractionEnabled = true
//        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self
//            , action:#selector(doubleTap(gesture:)))
//        doubleTapGesture.numberOfTapsRequired = 2
//        imageView.addGestureRecognizer(doubleTapGesture)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
//        self.updateImageCenter()
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
//        self.updateImageCenter()
        isDoubleTap = false
    }

    @objc
    func doubleTap(gesture: UITapGestureRecognizer) -> Void {
        
        if ( scrollView.zoomScale < scrollView.maximumZoomScale ) {
            
            isDoubleTap = true
            
            var tapPoint = gesture.location(in: gesture.view)
            tapPoint.x /= scrollView.zoomScale
            tapPoint.y /= scrollView.zoomScale
            
            let newScale:CGFloat = scrollView.zoomScale * 2
            let zoomRect:CGRect = zoomRectForScale(scale: newScale, center: tapPoint)
            scrollView.zoom(to: zoomRect, animated: true)
            
        } else {
            scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    func zoomRectForScale(scale:CGFloat, center: CGPoint) -> CGRect{
        
        var zoomRect: CGRect = CGRect()
        zoomRect.size.height = self.view.frame.size.height / scale
        zoomRect.size.width = self.view.frame.size.width / scale
        
        zoomRect.origin.x = center.x - zoomRect.size.width / 2.0
        zoomRect.origin.y = center.y - zoomRect.size.height / 2.0
        
        return zoomRect
    }
    
    func updateImageCenter() {
            
        if isDoubleTap {
            return
        }
//        let image = imageView.image
//        let frame = awakeRectWithAspectRatioInsideRect(image!.size, imageView.bounds)
//
//        var imageSize = CGSizeMake(frame.size.width, frame.size.height)
//        imageSize.width *= scrollView.zoomScale
//        imageSize.height *= scrollView.zoomScale
//
//        var point: CGPoint = CGPointZero
//        point.x = imageSize.width / 2
//        if imageSize.width < scrollView.bounds.width {
//            point.x += (scrollView.bounds.width - imageSize.width) / 2
//        }
//        point.y = imageSize.height / 2
//        if imageSize.height < scrollView.bounds.height {
//            point.y += (scrollView.bounds.height - imageSize.height) / 2
//        }
//        imageView.center = point
    }

}
