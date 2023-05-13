//
//  Output.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 25/04/23.
//

import Foundation
import SwiftUI

/// This struct exists as a sort of override so that "print" statements can be run within views
struct Output: View {
    var args: String

    /// Default intializer, takes one argument
    init(_ arg: String) {
        print(arg)
        args = arg
    }

    var body: some View {
        Text(self.args)
    }
}
