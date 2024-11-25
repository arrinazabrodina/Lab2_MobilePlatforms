//
//  HomeModule.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import Combine
import RealmSwift

struct Section<T> {
  
  let title: String
  let objects: [T]
  
}

final class HomeModule: Module,
                        ObjectStoreAccessing {
  
  @Published private(set) var content: [Section<CarModel>] = []
  @Published private(set) var isFilterEnabled = false
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
  }
  
  func applyFilters() {
    isFilterEnabled.toggle()
    updateContent()
  }
  
  func calculateAverageEngineVolume() -> Double {
    let sum = (objectStore.models.map({ $0.engineVolume }) as [Double]).reduce(0, +)
    let count = objectStore.models.count
    
    return sum / Double(count)
  }
  
}

private extension HomeModule {
  
  func setup() {
    updateContent()
  }
  
  func updateContent() {
    let content: [Section<CarModel>] = if isFilterEnabled {
      sections(from: objectStore.models.where {
        $0.color.equals(Constants.filterColor, options: .caseInsensitive)
        && $0.bodyStyle.equals(Constants.filterBodyStyle)
      }.map({ $0 }))
    }
    else {
      sections(from: objectStore.manufacturers.map({ $0 }))
    }
    
    self.content = content
  }
  
  func sections(from cars: [CarModel]) -> [Section<CarModel>] {
    cars.sectioned(by: \.manufacturer!.name)
  }
  
  func sections(from manufacturers: [Manufacturer]) -> [Section<CarModel>] {
    manufacturers.map {
      .init(
        title: $0.name,
        objects: $0.models.map({ $0 })
      )
    }
  }
  
}

extension Array {
  
  func sectioned(by keyPath: KeyPath<Element, String>) -> [Section<Element>] {
    var dictionary: [String: [Element]] = [:]
    
    for element in self {
      let key = element[keyPath: keyPath]
      dictionary[key, default: []].append(element)
    }
    
    return dictionary.map { key, value in
      Section<Element>(title: key, objects: value)
    }.sorted(by: their(\.title))
  }
  
}

func their<T, U: Comparable>(_ keypath: KeyPath<T, U>) -> ((T, T) -> Bool) {
  return {
    $0[keyPath: keypath] < $1[keyPath: keypath]
  }
}
