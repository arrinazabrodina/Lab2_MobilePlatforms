//
//  LocationDetailsModule.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import MapKit
import Combine

final class LocationDetailsModule: Module {
  
  let placemark: CLPlacemark
  
  private let locationManager = CLLocationManager()
  @Published private var currentLocation: CLLocation?
  
  @Published private(set) var distance: CLLocationDistance?
  @Published private(set) var route: MKRoute?
  
  private var subscriptions: Set<AnyCancellable> = []
  
  init(placemark: CLPlacemark) {
    self.placemark = placemark
    
    super.init()
  }
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
  }
  
}

private extension LocationDetailsModule {
  
  func setup() {
    locationManager.delegate = self
    
    $currentLocation
      .first(where: { $0 != nil })
      .sink { [weak self] location in
        self?.locationManager.stopUpdatingLocation()
        self?.updateDistance(with: location!)
        self?.calculateRoutes(with: location!)
      }.store(in: &subscriptions)
    
    
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
//    locationManager.startUpdatingLocation()
//    locationManager.startUpdatingHeading()
  }
    
  func updateDistance(with currentLocation: CLLocation) {
    guard let location = placemark.location else { return }
    distance = currentLocation.distance(from: location)
  }
  
  func calculateRoutes(with currentLocation: CLLocation) {
    let request = with(MKDirections.Request()) {
      $0.source = .init(placemark: MKPlacemark(coordinate: currentLocation.coordinate))
      $0.destination = .init(placemark: MKPlacemark(placemark: placemark))
      $0.transportType = .automobile
    }
    
    let direction = MKDirections(request: request)
    direction.calculate { [weak self] response, error in
      guard let response else {
        // handle error if needed
        return
      }
      self?.route = response.routes.first
    }
  }
  
}

extension LocationDetailsModule: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .denied {
      currentLocation = nil
    }
    
    locationManager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else {
      currentLocation = nil
      return
    }
    
    currentLocation = location
  }
  
  func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
    guard let location = manager.location else {
      return
    }
    
    currentLocation = location
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    print("Error: \(error)")
  }
  
}
