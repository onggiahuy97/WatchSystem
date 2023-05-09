//
//  ContactsView.swift
//  Watch System!
//
//  Created by Huy Ong on 5/9/23.
//

import SwiftUI
import Contacts

struct ContactsView: View {
    private let store = CNContactStore()
    
    @State private var errorMessage = ""
    @State private var contacts = [CNContact]()
    
    var body: some View {
        List(contacts, id: \.self) { contact in
            Text(contact.givenName)
        }
        .navigationTitle("Contacts")
        .onAppear(perform: requestAuthorization)
        .overlay(
            VStack {
                Text("Please check the privacy for access!")
                Button("Setting") {
                    Task {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            await UIApplication.shared.open(url)
                        }
                    }
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
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
    
        do {
            let containers = try store.containers(matching: nil)
            for container in containers {
                let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                
                do {
                    let containerResults = try store.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch)
                    contacts.append(contentsOf: containerResults)
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
