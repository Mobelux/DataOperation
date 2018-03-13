//
//  Request.swift
//  Mobelux
//
//  Created by Jeremy Greenwood on 3/13/18.
//  Copyright © 2018 Mobelux. All rights reserved.
//

import Foundation

public protocol Request {
    var httpMethod: String? { get set }
    var httpBody: Data? { get set }

    init(url: URL)
    mutating func addValue(_ value: String, forHTTPHeaderField field: String)
}

extension URLRequest: Request {
    public init(url: URL) {
        self.init(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
    }
}
