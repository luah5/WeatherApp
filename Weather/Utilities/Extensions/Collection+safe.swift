//
//  Collection+safe.swift
//  World Wide Weather
//
//  Created by Raymond Vleeshouwer on 13/05/23.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    /// Performs a safe way of getting an index from a Collection
    /// - Parameters:
    ///  - index: Index
    /// - Returns: The value of the Index, or nil if the index doesn't exist
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
