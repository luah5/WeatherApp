//
//  Float+removeZeros.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 27/04/23.
//

import Foundation

extension Float {
    /// Removes zeros from a float
    /// - Returns: A String copy of the float with removed zeros
    func removeZeros() -> String {
        return String(format: "%g", self)
    }
}
