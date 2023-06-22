//
//  Color+lerp.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 22/06/23.
//

import Foundation
import SwiftUI

extension Color {
    /// Performs linear interpolation (lerp) between two colors.
    /// - Parameters:
    ///   - color: The target color to interpolate towards.
    ///   - progress: The progress value between 0.0 and 1.0.
    /// - Returns: The interpolated color.
    func lerp(to color: Color, progress: Double = 0.5) -> Color {
        let nsColor = NSColor(self)
        let nsTargetColor = NSColor(color)

        guard let lerpedColor = nsColor.blended(withFraction: CGFloat(progress), of: nsTargetColor) else {
            return self
        }

        return Color(lerpedColor)
    }
}
