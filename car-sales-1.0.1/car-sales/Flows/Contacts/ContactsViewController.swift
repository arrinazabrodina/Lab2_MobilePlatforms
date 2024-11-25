//
//  ContactsViewController.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import UIKit
import Contacts
import Combine

final class ContactsViewController: UIViewController {
  
  typealias Module = ContactsModule
  
  let module: Module
  
  private let tableView = UITableView(frame: .zero, style: .grouped)
  
  private var Subscriptions: Set<AnyCancellable> = []
  
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

private extension ContactsViewController {
  
  func setup() {
    with(tableView) {
      $0.delegate = self
      $0.dataSource = self
      $0.register(ContactTableViewCell.self)
    }
    .add(to: view)
    .constrainEdgesToSuperview()
  }
  
  func setupBindings() {
    module.$contacts.sink { [weak self] _ in
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadData()
      }
    }.store(in: &Subscriptions)
  }
  
}

extension ContactsViewController: UITableViewDelegate,
                                  UITableViewDataSource {
  
  func contact(at indexPath: IndexPath) -> CNContact {
    module.contacts[indexPath.row]
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    module.contacts.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ContactTableViewCell = tableView.dequeue(for: indexPath)
    
    cell.display(contact: contact(at: indexPath))
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

