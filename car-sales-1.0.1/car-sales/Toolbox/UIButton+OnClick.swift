//
//  UIButton+OnClick.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit

extension UIButton {
  
  @discardableResult
  func onClick(_ block: @escaping () -> ()) -> Self {
    addAction(.init(handler: { _ in
      block()
    }), for: .touchUpInside)
    return self
  }
  
}

