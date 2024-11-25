//
//  Manufacturer.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import RealmSwift

final class Manufacturer: Object {
  
  @Persisted(primaryKey: true) var id: ObjectId
  @Persisted var name: String
  @Persisted var models: List<CarModel>
  
}
