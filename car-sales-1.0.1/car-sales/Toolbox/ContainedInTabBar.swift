//
//  ContainedInTabBar.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import Combine

protocol ContainedInTabBar {
  
  var didReceiveFocus: PassthroughSubject<Void, Never> { get }
  
}
