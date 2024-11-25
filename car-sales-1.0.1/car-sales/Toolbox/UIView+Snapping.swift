//
//  UIView+Snapping.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit
import SnapKit

extension UIView {
  
  @discardableResult
  func add(to superview: UIView) -> Self {
    superview.addSubview(self)
    return self
  }
  
  @discardableResult
  func pinToSuperview(
    leading: CGFloat? = nil,
    trailing: CGFloat? = nil,
    top: CGFloat? = nil,
    bottom: CGFloat? = nil
  ) -> Self {
    self.snp.makeConstraints { make in
      if let leading { make.leading.equalToSuperview().offset(leading) }
      if let trailing { make.trailing.equalToSuperview().offset(-trailing) }
      if let top { make.top.equalToSuperview().offset(top) }
      if let bottom { make.bottom.equalToSuperview().offset(-bottom) }
    }
    return self
  }
  
  @discardableResult
  func constrainEdgesToSuperview() -> Self {
    self.snp.makeConstraints { make in
      make.left.right.top.bottom.equalToSuperview()
    }
    return self
  }
  
  @discardableResult
  func pinCenterY() -> Self {
    self.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
    }
    return self
  }
  
}
