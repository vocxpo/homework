//
//  SceneDelegate.swift
//  OneMonth
//
//  Created by 呉翰 on 2019/11/23.
//  Copyright © 2019 呉翰. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let layout = UICollectionViewFlowLayout()
//        let flickrPhotoController = CalendarCollectionViewController(collectionViewLayout: layout)
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}

