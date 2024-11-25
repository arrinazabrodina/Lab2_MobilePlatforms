//
//  ContactsModule.swift
//  car-sales
//
//  Created by Arina Zabrodina on 23/11/2024.
//

import Foundation
import Contacts
import Combine

final class ContactsModule: Module,
                            ContactStoreAccessing {
  
  @Published private(set) var contacts: [CNContact] = []
  
  private var contactStoreSubscription: AnyCancellable?
  
  override func didMoveToParent() {
    super.didMoveToParent()
    
    setup()
  }
  
}

private extension ContactsModule {
  
  func setup() {
    contactStoreSubscription = contactStore.$contacts
      .sink { [weak self] in
        guard let self else { return }
        
        let contacts = filter(contacts: $0)
        
        self.contacts = contacts
      }
  }
  
  func contactsPredicate(_ contact: CNContact) -> Bool {
    
    let isValid = contact.phoneNumbers.contains {
      $0.value.stringValue.hasSuffix("7")
    }
    
    print()
    print("Name: ", contact.givenName, " ", contact.familyName)
    print("Contact numbers: ", contact.phoneNumbers.map(\.value.stringValue))
    print("valid: ", isValid)
    
    return isValid
  }
  
  func filter(contacts: [CNContact]) -> [CNContact] {
    contacts.filter(contactsPredicate)
  }
  
}
