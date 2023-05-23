//
//  Float+removeZeros.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 27/04/23.
//

import Foundation

/// Removes the trailing zeros in a Float.
extension Float {
    func removeZeros() -> String {
        return String(format: "%g", self)
    }
}
