//
//  SineLine.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 07/05/23.
//

import Foundation
import SwiftUI

/// Creates a sine line
struct SineLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let maxY = rect.midY

        // Assuming a full rotation of 360 degrees
        let stepX = rect.width / 360

        path.move(to: CGPoint(x: rect.minX, y: maxY))

        for angle in stride(from: 0, through: 360, by: 5) {
            let radianAngle = CGFloat(angle) * .pi / 180
            let xPos = rect.minX + CGFloat(angle) * stepX
            let yPos = sin(radianAngle) * rect.height / 2 + maxY

            path.addLine(to: CGPoint(x: xPos, y: yPos))
        }

        // Add the strikethrough line
        let strikeY = maxY
        path.move(to: CGPoint(x: rect.minX, y: strikeY))
        path.addLine(to: CGPoint(x: rect.maxX, y: strikeY))

        return path
    }
}
