//
//  ContactsView.swift
//  Watch System!
//
//  Created by Huy Ong on 5/9/23.
//

import SwiftUI
import Contacts
import iSwiftLib

extension CNContact {
    var phoneNumber: String {
        self.phoneNumbers.first?.value.stringValue ?? ""
    }
}

struct ContactsView: View {
    struct Contact: Identifiable {
        let id = UUID()
        let contact: CNContact
    }
    
    private let store = CNContactStore()
    
    @State private var errorMessage = ""
    @State private var contacts = [Contact]()
    
    var body: some View {
        FilteringList(
            contacts,
            filterKeys: \.contact.givenName, \.contact.phoneNumber,
            focus: true
        ) { item in
            VStack(alignment: .leading) {
                Text(item.contact.givenName)
                Text("\(item.contact.phoneNumber)")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Contacts")
        .onAppear(perform: requestAuthorization)
        .overlay(
            VStack {
                if !errorMessage.isEmpty {
                    Text("Please check the privacy for access!")
                    Button("Setting") {
                        Task {
                            #if os(macOS)
                            // Code specific to macOS
                            Button("Settings") {
                                if let url = URL(string: "x-apple.systempreferences:com.apple.preference.general") {
                                    NSWorkspace.shared.open(url)
                                }
                            }
                            #else
                            // Code specific to iOS/iPadOS
                            Button("Settings") {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            #endif
                        }
                    }
                } else {
                    Text(errorMessage)
                }
            }
                .opacity(contacts.count == 0 ? 1.0 : 0)
        )
    }
    
    private func requestAuthorization() {
        store.requestAccess(for: .contacts) { granted, error in
            if granted {
                fetchContacts()
            } else {
                errorMessage = error?.localizedDescription ?? ""
            }
        }
    }
    
    private func fetchContacts() {
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]
        
        do {
            let containers = try store.containers(matching: nil)
            for container in containers {
                let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                
                do {
                    let containerResults = try store.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch)
                    contacts.append(contentsOf: containerResults.map { Contact(contact: $0) })
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
