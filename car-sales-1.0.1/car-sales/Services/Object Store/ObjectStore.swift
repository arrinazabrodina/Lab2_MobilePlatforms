//
//  ObjectStore.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import RealmSwift

final class ObjectStore: Module {
  
  private let realm = try! Realm(configuration: .init(deleteRealmIfMigrationNeeded: true))
  
  private(set) lazy var manufacturers = realm.objects(Manufacturer.self)
  private(set) lazy var models = realm.objects(CarModel.self)
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    try? realm.write {
      realm.deleteAll()
    }
    
    if realm.objects(Manufacturer.self).isEmpty {
      prefill()
    }
    
    updateItems()
  }
  
}


private extension ObjectStore {
  
  func updateItems() {
    var manufacturers: [Manufacturer] = []
    var models: [CarModel] = []
    
    manufacturers.append(contentsOf: realm.objects(Manufacturer.self))
    models.append(contentsOf: realm.objects(CarModel.self))
  }
  
  func prefill() {
    let manufacturers: [Manufacturer] = [
      .audi,
      .mazda,
      .toyota,
      .volkswagen,
      .nissan,
      .chevrolet,
      .lexus
    ]
      .sorted(by: their(\.name))
    
    let models = manufacturers.flatMap({ $0.models.map { $0 }})
    
    let filteredModels = models.filter {
      $0.color == Constants.filterColor
      && $0.bodyStyle == Constants.filterBodyStyle
    }
    
    guard filteredModels.count >= 3 else {
      prefill()
      return
    }
    
    try? realm.write {
      realm.add(manufacturers)
    }
  }
  
}
