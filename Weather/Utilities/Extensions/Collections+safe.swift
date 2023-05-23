//
//  Collections+safe.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
