//
//  Sidebar.swift
//  Watch System!
//
//  Created by Huy Ong on 5/8/23.
//

import SwiftUI

enum Panel: Hashable {
    case contact
    case screenTime
}

struct Sidebar: View {
    @Binding var selection: Panel?

    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: Panel.contact) {
                CustomLabel("Contacts", systemName: "text.book.closed.fill", color: .gray)
            }
            
            NavigationLink(value: Panel.screenTime) {
                CustomLabel("Screen Time", systemName: "hourglass", color: .purple)
            }
        }
        .navigationTitle("Watch System!")
    }
    
}
