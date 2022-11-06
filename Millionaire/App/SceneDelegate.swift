//
//  SceneDelegate.swift
//  Millionaire
//
//  Created by Valery Keplin on 31.10.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = StartViewController()
        
        let navigatorController = UINavigationController(rootViewController: viewController)
        navigatorController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigatorController.navigationBar.shadowImage = UIImage()
        navigatorController.navigationBar.isTranslucent = true

        window?.rootViewController = navigatorController
        window?.makeKeyAndVisible()
    }
}
