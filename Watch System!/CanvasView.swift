//
//  CanvasView.swift
//  Watch System!
//
//  Created by Huy Ong on 5/13/23.
//

import SwiftUI

struct CanvasView: View {
    var body: some View {
        Canvas { context, size in
            let size = 220
            context.opacity = 0.5
            
            context.drawLayer { innerContext in
                let circle1 = Path(ellipseIn: .init(x: 100, y: 200, width: size, height: size))
                innerContext.fill(circle1, with: .color(.init(red: 1, green: 0, blue: 0)))
                
                let circle2 = Path(ellipseIn: .init(x: 100, y: 300, width: size, height: size))
                innerContext.fill(circle2, with: .color(.init(red: 0, green: 1, blue: 0)))
                
                let circle3 = Path(ellipseIn: .init(x: 100, y: 400, width: size, height: size))
                innerContext.fill(circle3, with: .color(.init(red: 0, green: 0, blue: 1)))
            }
        }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
