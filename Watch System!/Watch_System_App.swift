//
//  Watch_System_App.swift
//  Watch System!
//
//  Created by Huy Ong on 5/8/23.
//

import SwiftUI

@main
struct Watch_System_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .defaultSize(width: 1000, height: 650)
        #endif
    }
}
