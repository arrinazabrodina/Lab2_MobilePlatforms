//
//  MainCoordinator.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit

final class MainCoordinator: Coordinator,
                             ObjectStoreProviding,
                             ContactStoreProviding {
  
  let objectStore = ObjectStore()
  let contactStore = ContactStore()
  let tabBarController = UITabBarController()
  
  private let coordinatorChildren = [
    HomeCoordinator(),
    ContactsCoordinator(),
    MapCoordinator(),
    InfoCoordinator()
  ]
  
  override init() {
    super.init()
    
    setup()
  }
  
}

private extension MainCoordinator {
  
  func setup() {
    add(child: objectStore)
    
    coordinatorChildren.forEach {
      self.add(child: $0)
    }
    
    tabBarController.delegate = self
    tabBarController.viewControllers = coordinatorChildren.map(\.navigationController)
  }
  
}

extension MainCoordinator: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController,
                        didSelect viewController: UIViewController) {
    guard let coordinator = coordinatorChildren
      .first(where: { $0.navigationController == viewController }) as? ContainedInTabBar
    else { return }
    
    coordinator.didReceiveFocus.send()
  }
  
}
