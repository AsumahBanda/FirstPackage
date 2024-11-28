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
        return contactViewController
    }

    public func updateUIViewController(_ uiViewController: ContactViewController, context: Context) {
        // Update the ViewController here
    }
}

public class ContactViewController: UINavigationController {

    // MARK: public variables

    var navController: UINavigationController!
    var name: String = ""
    var emails: [String] = []
    var phoneNumbers: [String] = []
    var iconColor: UIColor = .white
    var imageData: Data?

    // MARK: life cycle methods

   public override func viewDidLoad() {
        let controller =  CNContactViewController(
            forNewContact: toCNContact()
        )
        controller.delegate = self
        viewControllers.append(controller)
        super.viewDidLoad()
    }

    // MARK: private methods

    private func toCNContact() -> CNMutableContact {
        let contact = CNMutableContact()
        contact.imageData = imageData
        contact.namePrefix = name
        contact.phoneNumbers = parseNumbers()
        contact.emailAddresses = parseEmails()
        return contact
    }

    private func parseNumbers() -> [CNLabeledValue<CNPhoneNumber>] {
        phoneNumbers.map { number in
                .init(
                    label: nil,
                    value: CNPhoneNumber(
                        stringValue: number
                    )
                )
        }
    }

    private func parseEmails() -> [CNLabeledValue<NSString>] {
        emails.map { email in
                .init(
                    label: nil,
                    value: NSString(
                        string: email
                    )
                )
        }
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
