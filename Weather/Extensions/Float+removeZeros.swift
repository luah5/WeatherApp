//
//  Float+removeZeros.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 27/04/23.
//

import Foundation

extension Float {
    func removeZeros() -> String {
        return String(format: "%g", self)
    }
}
