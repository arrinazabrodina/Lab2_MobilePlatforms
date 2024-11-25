//
//  Car.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import RealmSwift

/*
 id
 бренд
 тип кузова (седан, універсал, пікап, хетчбек)
 колір
 обʼєм двигуна (л)
 ціна
 */

enum CarBodyStyle: String, PersistableEnum {
  
  case sedan
  case kombi
  case crossover
  case hatchback
  
  var localizedTitle: String {
    switch self {
    case .sedan: "Cедан"
    case .kombi: "Універсал"
    case .crossover: "Кросовер"
    case .hatchback: "Хетчбек"
    }
  }
  
}

final class CarModel: Object {
  
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted(originProperty: "models") private(set) var manufacturers: LinkingObjects<Manufacturer>
  var manufacturer: Manufacturer? {
    manufacturers.first
  }
//  @Persisted var manufacturer: Manufacturer!
  
  @Persisted var name: String = ""
  @Persisted var bodyStyle: CarBodyStyle
  @Persisted var color: String = ""
  
  @Persisted private var _engineVolume: Int // cm3
  var engineVolume: Double { // liters
    get { Double(_engineVolume) / 1000.0 }
    set { _engineVolume = Int(newValue * 1000.0) }
  }
  
  @Persisted private var _price: Int // usd in coins
  var price: Double { // usd
    get { Double(_price) / 100.0 }
    set { _price = Int(newValue * 100.0) }
  }
  
  
}
