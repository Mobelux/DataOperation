//
//  Result.swift
//  Mobelux
//
//  Created by Jeremy Greenwood on 3/13/18.
//  Copyright © 2018 Mobelux. All rights reserved.
//

import Foundation

public enum Result<T, E: LocalizedError> {
    case success(T)
    case error(E)
}
