//
//  ObjectStore+Prefill.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation

extension Manufacturer {
  
  static func colors() -> [String] {
    [
      "Червоний",
      "Синій",
      "Зелений",
      "Білий",
      "Чорний",
      "Сірий"
    ]
  }
  
  static func randomColor() -> String {
    colors().randomElement()!
  }
  
static var audi: Manufacturer {
  let manufacturer = Manufacturer()
  manufacturer.name = "Audi"
  
  let models = [
    with(CarModel()) {
      $0.engineVolume = 1.0
      $0.name = "A1"
      $0.bodyStyle = .hatchback
      $0.price = 30_000
    },
    with(CarModel()) {
      $0.engineVolume = 1.6
      $0.name = "A3"
      $0.bodyStyle = .hatchback
      $0.price = 50_000
    },
    with(CarModel()) {
      $0.engineVolume = 2.0
      $0.name = "A5"
      $0.bodyStyle = .sedan
      $0.price = 70_000
    },
    with(CarModel()) {
      $0.engineVolume = 2.0
      $0.name = "A6"
      $0.bodyStyle = .kombi
      $0.price = 80_000
    },
    with(CarModel()) {
      $0.engineVolume = 2.0
      $0.name = "Q5"
      $0.bodyStyle = .crossover
      $0.price = 90_000
    },
  ]
  
  models.forEach {
    $0.color = randomColor()
  }
  
  manufacturer.models.append(objectsIn: models)
  
  return manufacturer
}
  
  static var mazda: Manufacturer {
    let manufacturer = Manufacturer()
    manufacturer.name = "Mazda"
    
    let models = [
      with(CarModel()) {
        $0.engineVolume = 1.6
        $0.name = "3"
        $0.bodyStyle = .hatchback
        $0.price = 40_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.0
        $0.name = "6"
        $0.bodyStyle = .kombi
        $0.price = 80_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.0
        $0.name = "CX-5"
        $0.bodyStyle = .crossover
        $0.price = 84_000
      },
    ]
    
    models.forEach {
      $0.color = randomColor()
    }
    
    manufacturer.models.append(objectsIn: models)
    
    return manufacturer
  }
  
  static var toyota: Manufacturer {
    let manufacturer = Manufacturer()
    manufacturer.name = "Toyota"
    
    let models = [
      with(CarModel()) {
        $0.engineVolume = 1.6
        $0.name = "Corolla"
        $0.bodyStyle = .sedan
        $0.price = 24_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.5
        $0.name = "Camry"
        $0.bodyStyle = .sedan
        $0.price = 35_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.5
        $0.name = "Rav4"
        $0.bodyStyle = .crossover
        $0.price = 50_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.5
        $0.name = "Highlander"
        $0.bodyStyle = .crossover
        $0.price = 58_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.0
        $0.name = "ProAce"
        $0.bodyStyle = .crossover
        $0.price = 36_000
      },
    ]
    
    models.forEach {
      $0.color = randomColor()
//      $0.manufacturer = manufacturer
    }
    
    manufacturer.models.append(objectsIn: models)
    
    return manufacturer
  }
  
  static var volkswagen: Manufacturer {
    let manufacturer = Manufacturer()
    manufacturer.name = "Volkswagen"
    
    let models = [
      with(CarModel()) {
        $0.engineVolume = 1.4
        $0.name = "Jetta"
        $0.bodyStyle = .sedan
        $0.price = 25_000
      },
      with(CarModel()) {
        $0.engineVolume = 1.4
        $0.name = "Golf"
        $0.bodyStyle = .hatchback
        $0.price = 30_000
      },
      with(CarModel()) {
        $0.engineVolume = 3.0
        $0.name = "Touareg"
        $0.bodyStyle = .crossover
        $0.price = 65_000
      },
      with(CarModel()) {
        $0.engineVolume = 1.8
        $0.name = "Passat"
        $0.bodyStyle = .sedan
        $0.price = 35_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.0
        $0.name = "Tiguan"
        $0.bodyStyle = .crossover
        $0.price = 40_000
      },
    ]
    
    models.forEach {
      $0.color = randomColor()
    }
    
    manufacturer.models.append(objectsIn: models)
    
    return manufacturer
  }
  
  static var nissan: Manufacturer {
    let manufacturer = Manufacturer()
    manufacturer.name = "Nissan"
    
    let models = [
      with(CarModel()) {
        $0.engineVolume = 1.5
        $0.name = "Qashqai"
        $0.bodyStyle = .crossover
        $0.price = 35_000
      },
      with(CarModel()) {
        $0.engineVolume = 1.5
        $0.name = "X-Trail"
        $0.bodyStyle = .crossover
        $0.price = 50_000
      },
      with(CarModel()) {
        $0.engineVolume = 1.0
        $0.name = "Juke"
        $0.bodyStyle = .crossover
        $0.price = 24_000
      },
        ]
    
    models.forEach {
      $0.color = randomColor()
    }
    
    manufacturer.models.append(objectsIn: models)
    
    return manufacturer
  }
  
  static var chevrolet: Manufacturer {
    let manufacturer = Manufacturer()
    manufacturer.name = "Chevrolet"
    
    let models = [
      with(CarModel()) {
        $0.engineVolume = 5.3
        $0.name = "Suburban"
        $0.bodyStyle = .crossover
        $0.price = 46_000
      },
      with(CarModel()) {
        $0.engineVolume = 3.6
        $0.name = "Camaro"
        $0.bodyStyle = .sedan
        $0.price = 35_500
      },
      with(CarModel()) {
        $0.engineVolume = 1.5
        $0.name = "Volt"
        $0.bodyStyle = .sedan
        $0.price = 18_000
      },
    ]
    
    models.forEach {
      $0.color = randomColor()
    }
    
    manufacturer.models.append(objectsIn: models)
    
    return manufacturer
  }
  
  static var lexus: Manufacturer {
    let manufacturer = Manufacturer()
    manufacturer.name = "Lexus"
    
    let models = [
      with(CarModel()) {
        $0.engineVolume = 2.5
        $0.name = "Rx"
        $0.bodyStyle = .crossover
        $0.price = 78_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.0
        $0.name = "Nx"
        $0.bodyStyle = .crossover
        $0.price = 50_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.5
        $0.name = "Es"
        $0.bodyStyle = .sedan
        $0.price = 53_000
      },
      with(CarModel()) {
        $0.engineVolume = 2.5
        $0.name = "Lx"
        $0.bodyStyle = .crossover
        $0.price = 125_000
      },
      with(CarModel()) {
        $0.engineVolume = 1.5
        $0.name = "Lbx"
        $0.bodyStyle = .crossover
        $0.price = 40_000
      },
    ]
    
    models.forEach {
      $0.color = randomColor()
    }
    
    manufacturer.models.append(objectsIn: models)
    
    return manufacturer
  }
  
}
