//
//  Session.swift
//  Mobelux
//
//  Created by Jeremy Greenwood on 3/13/18.
//  Copyright © 2018 Mobelux. All rights reserved.
//

import Foundation

public protocol Session {
    init(configuration: URLSessionConfiguration)
    func task(with request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SessionDataTask?
}

public protocol SessionDataTask {
    func resume()
}

extension URLSession: Session {
    public func task(with request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SessionDataTask? {
        guard let request = request as? URLRequest else {
            return nil
        }

        return dataTask(with: request, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: SessionDataTask {}
