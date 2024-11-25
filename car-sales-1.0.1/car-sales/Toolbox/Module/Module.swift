//
//  Module.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation

class Module: NSObject {
  
  weak var parent: Module? {
    didSet {
      guard parent != nil else { return }
      
      didMoveToParent()
    }
  }
  
  var children: Set<Module> = []
  
  func didMoveToParent() { }
  
  func add(child: Module) {
    children.insert(child)
    child.parent = self
  }
  
  func remove(child: Module) {
    children.remove(child)
    child.parent = nil
  }
  
  func removeFromParent() {
    parent?.remove(child: self)
  }
  
}

