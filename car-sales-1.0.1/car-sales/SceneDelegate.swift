//
//  SceneDelegate.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
//  private let mainModule: MainModule
//  private let mainController: MainViewController
  private let mainCoordinator = MainCoordinator()
  
//  override init() {
//    mainModule = MainModule()
//    mainController = MainViewController(module: mainModule)
//    
//    super.init()
//  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    let window = UIWindow(windowScene: scene)
    window.rootViewController = mainCoordinator.tabBarController
    window.makeKeyAndVisible()
    self.window = window
  }

}

