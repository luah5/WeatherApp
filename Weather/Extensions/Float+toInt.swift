//
//  Float+toInt.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

/// Instead of directly converting to Int, toInt() rounds itself and then converts its self to an integer.
extension Float {
    func toInt() -> Int {
        return Int(self.rounded())
    }
}
