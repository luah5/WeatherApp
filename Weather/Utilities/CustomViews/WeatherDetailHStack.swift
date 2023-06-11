//
//  WeatherDetailHStack.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 28/05/23.
//

import SwiftUI

struct WeatherDetailHStack<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        HStack(spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity)
    }
}
