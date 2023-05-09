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
                Label("Contacts", systemImage: "text.book.closed.fill")
            }
            
            NavigationLink(value: Panel.screenTime) {
                Label("Screen Time", systemImage: "hourglass")
            }
        }
        .navigationTitle("Watch System!")
    }
    
}
