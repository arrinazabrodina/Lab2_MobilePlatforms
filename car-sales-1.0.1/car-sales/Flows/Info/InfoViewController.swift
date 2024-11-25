//
//  InfoViewController.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit

final class InfoViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
}

private extension InfoViewController {
  
  func setup() {
    let avatarImageView = with(UIImageView()) {
      $0.layer.cornerRadius = 125.0
      $0.layer.masksToBounds = true
      $0.image = .init(named: "avatar")
      $0.snp.makeConstraints { make in
        make.width.height.equalTo(250.0)
      }
    }
      
    
    let avatarWrapper = avatarImageView
      .centerXWrapped()
    
    let nameLabel = with(UILabel()) {
      $0.text = "Аріна Забродіна\nГрупа ТТП-41"
      $0.numberOfLines = 0
      $0.textAlignment = .center
    }
    
    
    with(UIStackView()) {
      $0.axis = .vertical
      
      $0.addArrangedSubview(avatarWrapper)
      $0.addArrangedSubview(UIView().constrainHeight(to: 10.0))
      $0.addArrangedSubview(nameLabel)
    }
    .centerXWrapped()
    .add(to: view)
    .pinToSuperview(leading: .zero, trailing: .zero)
    .snp.makeConstraints { make in
      make.centerY.equalToSuperview()
    }
    
  }
  
}

extension UIView {
  
  func centerXWrapped() -> UIView {
    let wrapper = UIView()
    
    self
      .add(to: wrapper)
      .pinToSuperview(top: .zero, bottom: .zero)
      .snp.makeConstraints { make in
        make.centerX.equalToSuperview()
      }
    
    return wrapper
  }
  
  func constrainHeight(to height: CGFloat) -> Self {
    self.snp.makeConstraints { make in
        make.height.equalTo(height)
      }
    
    return self
  }
  
}
