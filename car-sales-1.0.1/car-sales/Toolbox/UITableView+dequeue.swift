//
//  UITableView+dequeue.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit

extension UITableView {
  
  private func identifier<T>(for type: T.Type) -> String {
    String(describing: type)
  }
  
  func register<T: UITableViewCell>(_ cell: T.Type) {
    register(cell, forCellReuseIdentifier: identifier(for: cell))
  }
  
  func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    dequeueReusableCell(withIdentifier: identifier(for: T.self), for: indexPath) as! T
  }
  
}
