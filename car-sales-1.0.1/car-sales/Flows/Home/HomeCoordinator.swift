//
//  HomeCoordinator.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation

final class HomeCoordinator: Coordinator {
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
    
    navigationController.tabBarItem = .init(title: "Автомобілі", image: .init(systemName: "car"), selectedImage: nil)
  }
  
}

private extension HomeCoordinator {
  
  func setup() {
    let module = HomeModule()
    add(child: module)
    
    let controller = HomeViewController(module: module)
    
    navigationController.pushViewController(controller, animated: true)
  }
  
}
