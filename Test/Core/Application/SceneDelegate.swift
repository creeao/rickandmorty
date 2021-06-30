//
//  SceneDelegate.swift
//  Test
//
//  Created by Eryk Chrustek on 29/06/2021.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let mainViewController = MainViewController()
        let navController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
