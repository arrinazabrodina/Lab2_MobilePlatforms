//
//  Functional.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation

@discardableResult
func with<T>(_ item: T, _ block: (T) -> Void) -> T {
  block(item)
  return item
}

@discardableResult
func edit<T>(_ item: T, _ block: (inout T) -> Void) -> T {
  var item = item
  block(&item)
  return item
}
