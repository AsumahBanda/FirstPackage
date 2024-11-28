import Contacts

public struct Contact {
    public var givenName: String = ""
    public var familyName: String = ""
    public var middleName: String = ""
    public var namePrefix: String = ""
    public var nameSuffix: String = ""
    public var nickname: String = ""
    public var organizationName: String = ""
    public var departmentName: String = ""
    public var jobTitle: String = ""
    public var phoneNumbers: [String] = []
    public var emailAddresses: [String] = []
    public var postalAddresses: [String] = [] 
    public var birthday: DateComponents?
    public var note: String = ""
    public var imageData: Data?

    public init(
        givenName: String = "",
        familyName: String = "",
        middleName: String = "",
        namePrefix: String = "",
        nameSuffix: String = "",
        nickname: String = "",
        organizationName: String = "",
        departmentName: String = "",
        jobTitle: String = "",
        phoneNumbers: [String] = [],
        emailAddresses: [String] = [],
        postalAddresses: [String] = [],
        birthday: DateComponents? = nil,
        note: String = "",
        imageData: Data? = nil
    ) {
        self.givenName = givenName
        self.familyName = familyName
        self.middleName = middleName
        self.namePrefix = namePrefix
        self.nameSuffix = nameSuffix
        self.nickname = nickname
        self.organizationName = organizationName
        self.departmentName = departmentName
        self.jobTitle = jobTitle
        self.phoneNumbers = phoneNumbers
        self.emailAddresses = emailAddresses
        self.postalAddresses = postalAddresses
        self.birthday = birthday
        self.note = note
        self.imageData = imageData
    }

    /// Convert `Contact` to `CNMutableContact`
    public func toCNMutableContact() -> CNMutableContact {
        let contact = CNMutableContact()
        contact.givenName = givenName
        contact.familyName = familyName
        contact.middleName = middleName
        contact.namePrefix = namePrefix
        contact.nameSuffix = nameSuffix
        contact.nickname = nickname
        contact.organizationName = organizationName
        contact.departmentName = departmentName
        contact.jobTitle = jobTitle
        contact.phoneNumbers = phoneNumbers.map {
            CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: $0))
        }
        contact.emailAddresses = emailAddresses.map {
            CNLabeledValue(label: CNLabelHome, value: $0 as NSString)
        }
        contact.postalAddresses = postalAddresses.map {
            let postalAddress = CNMutablePostalAddress()
            postalAddress.street = $0 // Assuming plain street string for simplicity
            return CNLabeledValue(label: CNLabelHome, value: postalAddress)
        }
        contact.birthday = birthday
        contact.note = note
        contact.imageData = imageData
        return contact
    }
}
