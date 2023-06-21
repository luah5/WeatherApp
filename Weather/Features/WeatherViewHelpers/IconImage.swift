//
//  IconImage.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 25/04/23.
//

import Foundation
import SwiftUI

/// This struct is for storing an icon image for weather icons
struct IconImage {
    init(
        image: Image,
        color: Color = .black
    ) {
        self.image = image
        self.color = color
    }

    let image: Image
    let color: Color
}
