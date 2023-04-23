//
//  Float+Int.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 23/04/23.
//

import Foundation

extension Float {
    func toInt() -> Int {
        return Int(self.rounded())
    }
}
