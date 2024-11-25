//
//  ContactTableViewCell.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit
import Contacts

final class ContactTableViewCell: UITableViewCell {
  
  private let nameLabel = UILabel()
  private let phoneNumberLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func display(contact: CNContact) {
    let name = contact.givenName + " " + contact.familyName
    nameLabel.text = name
    phoneNumberLabel.text = contact.phoneNumbers
      .map(\.value.stringValue)
      .joined(separator: "\n")
  }
  
}

private extension ContactTableViewCell {
  
  func setup() {
    nameLabel.text = "Test"
    phoneNumberLabel.text = "test"
    with(UIStackView()) {
      $0.axis = .vertical
      
      $0.addArrangedSubview(nameLabel)
      $0.addArrangedSubview(phoneNumberLabel)
    }
    .add(to: contentView)
    .pinToSuperview(leading: 20.0, trailing: 20.0, top: 15.0, bottom: 15.0)
    
    phoneNumberLabel.numberOfLines = 0
  }
  
}

