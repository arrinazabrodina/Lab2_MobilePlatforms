//
//  Module+Lookup.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation

extension Module {
  
  func firstPredecessor<T>(of type: T.Type) -> T? {
    firstPredecessor(matching: { $0 is T }) as? T
  }
  
  func firstPredecessor(matching condition: (Module) -> Bool) -> Module? {
    condition(self) ? self : parent?.firstPredecessor(matching: condition)
  }
  
}
