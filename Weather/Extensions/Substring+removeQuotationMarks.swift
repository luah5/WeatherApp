//
//  String+jsonDecode.swift
//  Weather
//
//  Created by Raymond Vleeshouwer on 17/04/23.
//

import Foundation
import AppKit

extension Substring {
    func removeQuotationMarks() -> String {
        return String(
            self.replacingOccurrences(of: "\"", with: "",
            options: NSString.CompareOptions.literal,
            range: nil)
        )
    }
}
