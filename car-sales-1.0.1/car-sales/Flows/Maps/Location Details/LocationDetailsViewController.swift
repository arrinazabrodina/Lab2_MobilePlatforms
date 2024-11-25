//
//  LocationDetailsViewController.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit
import MapKit
import Combine

final class LocationDetailsViewController: UIViewController {
  
  typealias Module = LocationDetailsModule
  
  let module: Module
  
  private let distanceLabel = UILabel()
  private let mapView = MKMapView()
  
  private var subscriptions: Set<AnyCancellable> = []
  
  init(module: Module) {
    self.module = module
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    setupBindings()
  }
  
}

private extension LocationDetailsViewController {
  
  func setupBindings() {
    module.$distance.sink { [weak self] distance in
      let text = if let distance {
        String(format: "Відстань до місця: %0.2f метри", distance)
      }
      else { "Не можу порахувати відстань без поточної локації" }
      
      self?.distanceLabel.text = text
    }.store(in: &subscriptions)
    
    module.$route.sink { [weak self] route in
      guard let self else { return }
      
      self.mapView.alpha = route == nil ? .zero : 1.0
      
      guard let route else { return }
      
      self.mapView.addOverlay(route.polyline)
      self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
    }.store(in: &subscriptions)
  }
  
  func setup() {
    view.backgroundColor = .white
    distanceLabel.numberOfLines = 0
    
    let distanceWrapper = UIView()
    
    distanceLabel
      .add(to: distanceWrapper)
      .pinToSuperview(leading: 20.0, trailing: 20.0, top: .zero, bottom: .zero)
    
    mapView.delegate = self
    
    with(UIStackView()) {
      $0.axis = .vertical
      $0.spacing = 16.0
      $0.addArrangedSubview(distanceWrapper)
      $0.addArrangedSubview(mapView)
    }
    .add(to: view)
    .pinToSuperview(leading: .zero, trailing: .zero, top: 100.0, bottom: .zero)
  }
  
}

extension LocationDetailsViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
    let overlay = overlay as? MKPolyline
    let gradientColors = [UIColor.systemRed, UIColor.systemRed]
    
    let polylineRenderer = MKGradientPolylineRenderer(overlay: overlay!)
    polylineRenderer.setColors(gradientColors, locations: polylineRenderer.locations)
    
    polylineRenderer.lineWidth = 10
    return polylineRenderer
  }
  
}
