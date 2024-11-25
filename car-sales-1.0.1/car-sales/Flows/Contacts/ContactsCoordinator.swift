//
//  ContactsCoordinator.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import Combine

final class ContactsCoordinator: Coordinator,
                                 ContainedInTabBar,
                                 ContactStoreAccessing {
  
  let didReceiveFocus = PassthroughSubject<Void, Never>()
  
  private var didReceiveFocusSubscription: AnyCancellable?
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
    setupBindings()
  }
  
}

private extension ContactsCoordinator {
  
  func setupBindings() {
    didReceiveFocusSubscription = didReceiveFocus.sink { [weak self] in
      self?.contactStore.requestAccessIfNeeded()
    }
  }
  
  func setup() {
    navigationController.tabBarItem = .init(
      title: "Контакти",
      image: .init(systemName: "person.crop.circle"),
      selectedImage: .init(systemName: "person.crop.circle.fill")
    )
    
    let module = ContactsModule()
    add(child: module)
    
    let controller = ContactsViewController(module: module)
    
    navigationController.pushViewController(controller, animated: true)
  }
  
}

