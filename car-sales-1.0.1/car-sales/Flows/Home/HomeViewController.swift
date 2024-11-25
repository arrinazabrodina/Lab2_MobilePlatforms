//
//  HomeViewController.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit
import SnapKit
import Toast_Swift
import Combine

final class HomeViewController: UIViewController {
  
  typealias Module = HomeModule
  
  let module: Module
  let tableView = UITableView(frame: .zero, style: .insetGrouped)
  
  private var contentSubscription: AnyCancellable?
  private var isFilterEnabledSubscription: AnyCancellable?
  
  init(module: Module) {
    self.module = module
    
    super.init(nibName: nil, bundle: nil)
  }
  
  deinit {
    module.removeFromParent()
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

private extension HomeViewController {
  
  func setup() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: .init(systemName: "info.circle.fill"),
      primaryAction: .init(handler: { [unowned self] _ in
        handleInfoTap()
      })
    )
    
    with(tableView) {
      $0.delegate = self
      $0.dataSource = self
      $0.register(CarModelTableViewCell.self)
    }
    .add(to: view)
    .constrainEdgesToSuperview()
  }
  
  func setupBindings() {
    contentSubscription = module.$content.sink { [weak self] _ in
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }
    
    isFilterEnabledSubscription = module.$isFilterEnabled.sink { [weak self] isFilterEnabled in
      guard let self else { return }
      
      navigationItem.leftBarButtonItem = self.makeFilterNavItem(
        with: isFilterEnabled
        ? .init(systemName: "line.3.horizontal.decrease.circle.fill")
        : .init(systemName: "line.3.horizontal.decrease.circle")
      )
    }
    
  }
  
  func handleInfoTap() {
    let avgEngineVolume = module.calculateAverageEngineVolume()
    
    view.makeToast(
      String(format: "Середній обʼєм двигуна: %0.01fL", avgEngineVolume),
      position: .center
    )
  }
  
  func makeFilterNavItem(with icon: UIImage?) -> UIBarButtonItem {
    UIBarButtonItem(image: icon, primaryAction: .init(handler: { [unowned self] _ in
      self.module.applyFilters()
      
      if module.isFilterEnabled {
        view.makeToast(
          "Фільтр (\(Constants.filterColor) та тип кузову \(Constants.filterBodyStyle.localizedTitle)) увімкнено",
          position: .bottom
        )
      }
      else {
        view.makeToast(
          "Фільтр вимкнено",
          position: .bottom
        )
      }
    }))
  }
  
}

extension HomeViewController: UITableViewDelegate,
                              UITableViewDataSource {
  
  private func carModel(for indexPath: IndexPath) -> CarModel {
    module.content[indexPath.section].objects[indexPath.row]
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    module.content.count
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    module.content[section].objects.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CarModelTableViewCell = tableView.dequeue(for: indexPath)
    
    cell.display(manufacturer: carModel(for: indexPath))
    
    return cell
  }
  
  func tableView(_ tableView: UITableView,
                 titleForHeaderInSection section: Int) -> String? {
    module.content[section].title
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let car = carModel(for: indexPath)
    
    
    /*
     Audi A3, хетчбек, 2.0L
     Червоний колір
     $20000
    */
    let message = String(
      format: """
%@ %@, %@, %0.01fL
%@ колір
$%.02f
""",
      car.manufacturer!.name, car.name, car.bodyStyle.localizedTitle, car.engineVolume,
      car.color,
      car.price
    )
    
    view.makeToast(message, position: .center)
  }
  
}
