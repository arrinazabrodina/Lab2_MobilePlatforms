//
//  MapModule.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import Combine
import MapKit

final class MapModule: Module {
  
  var didReqeustLocations: ((MapModule, [CLPlacemark]) -> Void)?
  
  @Published private(set) var text: String = ""
  @Published private(set) var isValid: Bool = false
  
  let errorPipe = PassthroughSubject<String, Never>()
  
  private var subscriptions: Set<AnyCancellable> = []
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
  }
  
  func apply(text: String) {
    self.text = text
  }
  
  func startSearch() {
    guard !text.isEmpty else { return }
    
    Task { @MainActor in
      
      do {
        let locations = try await CLGeocoder().geocodeAddressString(text)
        
        guard !locations.isEmpty else {
          errorPipe.send("Жодної локації не було знайдено")
          return
        }
        
        didReqeustLocations?(self, locations)
      }
      catch {
        errorPipe.send("Помилка під час пошуку локації: \(error.localizedDescription)")
      }
    }
  }
  
}

private extension MapModule {
  
  func setup() {
    $text
      .map { $0.count > 0 }
      .assign(to: &$isValid)
  }
  
}
