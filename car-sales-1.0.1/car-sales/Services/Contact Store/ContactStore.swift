//
//  ContactStore.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import Contacts

final class ContactStore: Module {
  
  let contactStore = CNContactStore()
  
  @Published private(set) var contacts: [CNContact] = []
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    
  }
  
  func requestAccessIfNeeded() {
    guard contacts.isEmpty else { return }
    
    requestAccess()
  }
  
}

private extension ContactStore {
  
  func requestAccess() {
    contactStore.requestAccess(for: .contacts) { [weak self] result, error in
      if let error {
        return
      }
      
      self?.fetchContacts()
    }
  }
  
  func fetchContacts() {
    let containers = (try? contactStore.containers(matching: nil)) ?? []
    
    for container in containers {
      let predicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
      let contacts = try? contactStore.unifiedContacts(
        matching: predicate,
        keysToFetch: [
          CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
          CNContactPhoneNumbersKey,
        ] as! [CNKeyDescriptor]
      )
      self.contacts.append(contentsOf: contacts ?? [])
    }
  }
  
}
