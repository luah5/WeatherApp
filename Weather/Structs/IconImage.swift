//
//  IconImage.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 25/04/23.
//

import Foundation
import SwiftUI

/// This struct is for storing an Icon image for weather icons
struct IconImage {
    var image: Image, color: Color

    init(image: Image, color: Color) {
        self.image = image
        self.color = color
    }
}
