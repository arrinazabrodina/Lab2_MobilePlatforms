//
//  ShortTextInputFieldView.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit

final class ShortTextInputFieldView: UIView {
  
  var didInputText: ((ShortTextInputFieldView, String) -> Void)?
  
  private let titleLabel = UILabel()
  private let textField = UITextField()
  
  var title: String = "" {
    didSet {
      titleLabel.text = title
      titleLabel.isHidden = title.isEmpty
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

private extension ShortTextInputFieldView {
  
  func setup() {
    titleLabel.isHidden = true
    
    textField.delegate = self
    
    let fieldWrapper = with(UIView()) {
      textField
        .add(to: $0)
        .pinToSuperview(leading: 20.0, trailing: 20.0, top: 15.0, bottom: 15.0)
      $0.layer.cornerRadius = 10.0
      $0.layer.cornerCurve = .continuous
      $0.layer.borderWidth = 1.0
      $0.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    with(UIStackView()) {
      $0.axis = .vertical
      $0.spacing = 10.0
      $0.addArrangedSubview(titleLabel)
      $0.addArrangedSubview(fieldWrapper)
    }
    .add(to: self)
    .constrainEdgesToSuperview()
    
    textField.addAction(.init(handler: { [weak self] _ in
      guard let self else { return }
      
      didInputText?(self, textField.text ?? "")
    }), for: .editingChanged)
  }
  
}

extension ShortTextInputFieldView: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    return false
  }
  
}
