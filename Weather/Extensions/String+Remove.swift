//
//  String+removeFirstAndLast.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 21/04/23.
//

import Foundation

extension String {
    func formatJSONString() -> String {
        return self.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    }
}
