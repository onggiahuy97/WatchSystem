//
//  Sidebar.swift
//  Watch System!
//
//  Created by Huy Ong on 5/8/23.
//

import SwiftUI
import iSwiftLib

enum Panel: String, Hashable, Identifiable, CaseIterable {
    case contact
    case screenTime
    
    var name: String {
        self.rawValue
    }
    
    var id: String {
        self.rawValue
    }
    
    @ViewBuilder
    var content: some View {
        switch self {
        case .contact:
            NavigationLink(value: Panel.contact) {
                CustomLabel("Contacts", systemName: "text.book.closed.fill", color: .gray)
            }
        case .screenTime:
            NavigationLink(value: Panel.screenTime) {
                CustomLabel("Screen Time", systemName: "hourglass", color: .purple)
            }
        }
    }
    
    
}

struct Sidebar: View {
    @Binding var selection: Panel?
    
    @State private var filteredString = ""
    @State private var panels: [Panel] = []
    
    var body: some View {
        VStack {
            TextField("Search", text: $filteredString.onChange {
                if filteredString.isEmpty {
                    panels = Panel.allCases
                } else {
                    panels = Panel.allCases.filter { $0.rawValue.localizedCaseInsensitiveContains(filteredString) }
                }
            })
            .padding(.horizontal)
            .textFieldStyle(.roundedBorder)
            
            List(panels, selection: $selection) { panel in
                panel.content
            }
        }
        .navigationTitle("Watch System!")
        .onAppear {
            panels = Panel.allCases
        }
    }
    
}
