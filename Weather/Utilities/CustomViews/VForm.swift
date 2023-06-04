//
//  VForm.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 27/05/23.
//

import SwiftUI

struct VForm<Content: View>: View {
    @ViewBuilder var content: Content
    let opacity: Double = 0.5

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
                .foregroundColor(.white)
                .opacity(opacity)
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(20)
        .padding()
        .edgesIgnoringSafeArea(.all)
    }
}
