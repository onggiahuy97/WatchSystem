//
//  View+Extensions.swift
//  Watch System!
//
//  Created by Huy Ong on 5/9/23.
//

import SwiftUI

struct CustomLabel: View {
    let title: String
    let systemName: String
    let color: Color
    
    init(_ title: String, systemName: String, color: Color = .blue) {
        self.title = title
        self.systemName = systemName
        self.color = color
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: systemName)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(color)
                .cornerRadius(6)
            Text(title)
        }
    }
}
