//
//  Url+extension.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = URL(string: value.description) else {
            fatalError("Invalid URL string: \(value)")
        }

        self = url
    }
}
