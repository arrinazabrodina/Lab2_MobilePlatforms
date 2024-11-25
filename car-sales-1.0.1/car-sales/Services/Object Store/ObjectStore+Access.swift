//
//  ObjectStore+Access.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation

protocol ObjectStoreProviding {
  
  var objectStore: ObjectStore { get }
  
}

protocol ObjectStoreAccessing { }

extension ObjectStoreAccessing where Self: Module {
  
  private var provider: ObjectStoreProviding! {
    firstPredecessor(of: ObjectStoreProviding.self)
  }
  
  var objectStore: ObjectStore {
    provider.objectStore
  }
  
}
