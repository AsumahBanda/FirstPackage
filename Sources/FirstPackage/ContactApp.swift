//
//  File.swift
//  
//
//  Created by AMALITECH-PC-593 on 11/28/24.
//

import Foundation
import Contacts
import ContactsUI
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif


#if os(iOS)
public struct ContactAppView: UIViewControllerRepresentable {
    
    // MARK: - public variables
    
    let contact: Contact
    let imageData: Data
    public typealias UIViewControllerType = ContactViewController
    @Environment(\.colorScheme) var colorScheme
    
    // MARK: - Lifecycle methods

   public init(contact: Contact, imageData: Data) {
       self.contact = contact
       self.imageData = imageData
   }
    
    public func makeUIViewController(context: Context) -> ContactViewController {
        let contactViewController = ContactViewController()
        contactViewController.setContact(contact)
        return contactViewController
    }

    public func updateUIViewController(_ uiViewController: ContactViewController, context: Context) {
        // Update the ViewController here
    }
}

public class ContactViewController: UINavigationController {
    
    // MARK: public variables
    
    var navController: UINavigationController!
    var contact: Contact = Contact()
    
    // MARK: life cycle methods
    
    public override func viewDidLoad() {
        print("contact \(contact)")
        let controller =  CNContactViewController(
            forNewContact: contact.toCNMutableContact()
        )
        controller.delegate = self
        viewControllers.append(controller)
        super.viewDidLoad()
    }
    
    // MARK: - public methods
    func setContact(_ contact: Contact) {
        self.contact = contact
    }
}

extension ContactViewController: CNContactViewControllerDelegate {
    public func contactViewController(
        _ viewController: CNContactViewController,
        didCompleteWith contact: CNContact?
    ) {
        dismiss(animated: true)
    }

    public func contactViewController(
        _ viewController: CNContactViewController,
        shouldPerformDefaultActionFor property: CNContactProperty
    ) -> Bool {
        true
    }
}
#endif
