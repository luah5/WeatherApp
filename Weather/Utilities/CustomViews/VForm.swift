//
//  VForm.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 27/05/23.
//

import SwiftUI

struct VForm<Content: View>: View {
    let opacity: Double = 0.5
    let color: Color
    let content: Content

    init(color: Color = .cyan, @ViewBuilder content: () -> Content) {
        if color == .cyan {
            self.color = LazyWeatherData().background.color.lerp(to: .white, progress: 0.6)
        } else {
            self.color = color.lerp(to: .white, progress: 0.6)
        }
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    content
                        .frame(alignment: .leading)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(10)
        }
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(color)
                .opacity(opacity)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}
