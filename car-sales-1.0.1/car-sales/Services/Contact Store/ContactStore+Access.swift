//
//  ContactStore+Access.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation

protocol ContactStoreProviding {
  
  var contactStore: ContactStore { get }
  
}

protocol ContactStoreAccessing { }

extension ContactStoreAccessing where Self: Module {
  
  private var provider: ContactStoreProviding! {
    firstPredecessor(of: ContactStoreProviding.self)
  }
  
  var contactStore: ContactStore {
    provider.contactStore
  }
  
}
