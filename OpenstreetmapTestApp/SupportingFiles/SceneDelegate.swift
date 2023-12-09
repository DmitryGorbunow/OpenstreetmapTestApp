//
//  SceneDelegate.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/7/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator : AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let navigationCon = UINavigationController.init()
        appCoordinator = AppCoordinator(navCon: navigationCon)
        appCoordinator?.start()
        self.window?.rootViewController = navigationCon
        self.window?.makeKeyAndVisible()
    }
}

