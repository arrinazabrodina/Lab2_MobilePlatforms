//
//  InfoCoordinator.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation


final class InfoCoordinator: Coordinator {
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
  }
  
}

private extension InfoCoordinator {
  
  func setup() {
    navigationController.tabBarItem = .init(
      title: "Про розробника",
      image: .init(systemName: "person"),
      selectedImage: .init(systemName: "person.fill")
    )
    
    let controller = InfoViewController()
    
    navigationController.pushViewController(controller, animated: true)
  }
  
}

