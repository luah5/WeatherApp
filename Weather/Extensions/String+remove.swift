//
//  String+remove.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 21/04/23.
//

import Foundation

extension String {
    func removePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func removePrefix(_ count: Int) -> String {
        return String(self.dropFirst(count))
    }
}
