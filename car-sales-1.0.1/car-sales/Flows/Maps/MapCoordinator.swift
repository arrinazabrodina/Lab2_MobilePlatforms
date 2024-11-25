//
//  MapCoordinator.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import MapKit

final class MapCoordinator: Coordinator {
  
  static let placemarkTitleExtractor: ((CLPlacemark) -> String) = {
    $0.name ?? ""
  }
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
  }
  
}

private extension MapCoordinator {
  
  func setup() {
    navigationController.tabBarItem = .init(
      title: "Мапи",
      image: .init(systemName: "map"),
      selectedImage: .init(systemName: "map.fill")
    )
    
    let module = MapModule()
    add(child: module)
    
    module.didReqeustLocations = { [weak self] _, locations in
      self?.showLocationsPicker(locations)
    }
    
    let controller = MapViewController(module: module)
    
    navigationController.pushViewController(controller, animated: true)
  }
  
  func showLocationsPicker(_ locations: [CLPlacemark]) {
    guard !locations.isEmpty else { return }
    
    guard locations.count > 1 else {
      showLocationDetails(locations.first!)
      return
    }
    
    let controller = UIAlertController(
      title: "Виберіть місце",
      message: "Було знайдено декілька місць. Виберіть одне місце, до якого треба прокласти маршрут",
      preferredStyle: .actionSheet
    )
    
    for location in locations {
      let action = UIAlertAction(title: Self.placemarkTitleExtractor(location), style: .default) { [weak self] _ in
        self?.showLocationDetails(location)
      }
      
      controller.addAction(action)
    }
    
    let cancelAction = UIAlertAction(title: "Скасувати", style: .cancel)
    controller.addAction(cancelAction)
    
    navigationController.present(controller, animated: true)
  }
  
  func showLocationDetails(_ location: CLPlacemark) {
    let module = LocationDetailsModule(placemark: location)
    add(child: module)
    
    let controller = LocationDetailsViewController(module: module)
    
    navigationController.present(controller, animated: true)
  }
  
}

