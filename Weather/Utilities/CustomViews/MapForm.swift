//
//  MapForm.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 02/06/23.
//

import SwiftUI

struct MapForm<Content: View>: View {
    @ViewBuilder var content: Content
    let opacity: Double = 0.5

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .center, spacing: 20) {
                    content
                        .frame(alignment: .center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(10)
        }
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(.white)
                .opacity(opacity)
        )
        .frame(maxWidth: .infinity)
        .padding(20)
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}
