//
//  CarModelTableViewCell.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit

final class CarModelTableViewCell: UITableViewCell {
  
  private let titleLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func display(manufacturer: CarModel) {
    titleLabel.text = manufacturer.name
  }
  
}

private extension CarModelTableViewCell {
  
  func setup() {
    titleLabel
      .add(to: contentView)
      .pinToSuperview(leading: 20.0, trailing: 20.0, top: 15.0, bottom: 15.0)
  }
  
}
