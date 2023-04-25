//
//  PreviewColor.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 25/04/23.
//

import Foundation
import SwiftUI

struct PreviewColor: View {
    private var color: Color
    private var width: CGFloat

    init(_ color: Color, width: CGFloat) {
        self.color = color
        self.width = width
    }

     var body: some View {
        color
            .frame(width: width, height: 5)
            .cornerRadius(5)
    }
}
