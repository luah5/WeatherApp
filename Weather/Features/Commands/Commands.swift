//
//  Commands.swift
//  Weathe r
//
//  Created by Raymond Vleeshouwer on 01/06/23.
//

import Foundation
import SwiftUI

struct WACommands: Commands {
    var body: some Commands {
        CommandMenu("Split") {
            Button("Split vertically") { }
                .keyboardShortcut("[")
                .disabled(true)
            Button("Split horizontally") { }
                .keyboardShortcut("]")
                .disabled(true)
        }
    }
}
