//
//  MapViewController.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit
import Combine

final class MapViewController: UIViewController {
  
  typealias Module = MapModule
  
  let module: Module
  
  private let textFieldView = ShortTextInputFieldView()
  private let searchButton = UIButton(type: .system)
  private var subscriptions: Set<AnyCancellable> = []
  
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

private extension MapViewController {
  
  func setupBindings() {
    module.$isValid.sink { [weak self] isValid in
      guard let self else { return }
      
      self.searchButton.setTitleColor(
        isValid ? .systemBlue : .gray,
        for: .normal
      )
    }.store(in: &subscriptions)
    
    module.errorPipe.sink { [weak self] error in
      guard let self else { return }
      
      view.makeToast(
        error,
        position: .center,
        style: edit(.init()) {
          $0.titleColor = .systemOrange
        }
      )
    }.store(in: &subscriptions)
  }
  
  func setup() {
    view.backgroundColor = .white
    with(textFieldView) {
      $0.title = "Введіть локацію"
      $0.didInputText = { [weak self] _, text in
        self?.module.apply(text: text)
      }
    }
    
    with(searchButton) {
      $0.setTitle("Пошук", for: .normal)
    }
      .onClick { [unowned self] in
        guard module.isValid else {
          view.makeToast("Треба ввести текст для пошуку", position: .center)
          return
        }
        
        module.startSearch()
      }
    
    with(UIStackView()) {
      $0.axis = .vertical
      $0.spacing = 16
      $0.addArrangedSubview(textFieldView)
      $0.addArrangedSubview(searchButton)
    }
      .add(to: view)
      .pinCenterY()
      .pinToSuperview(leading: 20.0, trailing: 20.0)
  }
  
}

