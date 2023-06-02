//
//  WeatherDetailHStack.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 28/05/23.
//

import SwiftUI

struct WeatherDetailHStack<Content: View>: View {
    @ViewBuilder var content: Content
    var detailViewWidth: CGFloat = 150
    var detailViewHeight: CGFloat = 150

    var body: some View {
        HStack(spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity)
    }
}