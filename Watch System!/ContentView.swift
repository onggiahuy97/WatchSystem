//
//  ContentView.swift
//  Watch System!
//
//  Created by Huy Ong on 5/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Panel? = nil
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $selection)
        } detail: {
            NavigationStack(path: $path) {
                DetailColumn(selection: $selection)
            }
        }
        .onChange(of: selection) { _ in
            path.removeLast(path.count)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
