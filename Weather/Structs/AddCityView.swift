//
//  AddCityView.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 01/05/23.
//

import SwiftUI

struct AddCityView: View {
    @State private var sheetIsPresented: Bool = false
    @State private var address: String = ""

    var body: some View {
        Button("Add city") {
            sheetIsPresented.toggle()
        }
        .sheet(isPresented: $sheetIsPresented) {
            VStack {
                TextField("Add a city, town, village or address", text: $address)
            }
            .frame(width: 100, height: 100)
        }
    }
}
