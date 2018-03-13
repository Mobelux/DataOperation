//
//  DataOperation.swift
//  Mobelux
//
//  Created by Jeremy Greenwood on 3/13/18.
//  Copyright © 2018 Mobelux. All rights reserved.
//

import Foundation

enum DataError: LocalizedError {
    case unknown
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .unknown: return NSLocalizedString("Generic.unknownError", comment: "")
        case .custom(let message): return message
        }
    }
}

final class DataOperation: Operation {
    private let request: Request
    private let session: Session

    var result: Result<Data, DataError>?

    init(request: Request, session: Session = URLSession(configuration: URLSessionConfiguration.default)) {
        self.request = request
        self.session = session
    }

    override func start() {
        let task = session.task(with: request) { [weak self] data, _, error in
            guard let sself = self else {
                return
            }

            if let data = data {
                sself.update(.success(data))
            } else if let error = error {
                sself.update(.error(.custom(error.localizedDescription)))
            } else {
                sself.update(.error(.unknown))
            }
        }

        task?.resume()
    }

    public override func cancel() {
        super.cancel()
    }

    override public var isExecuting: Bool {
        return result == nil
    }

    override public var isFinished: Bool {
        return result != nil
    }

    override public var isAsynchronous: Bool {
        return true
    }
}

private extension DataOperation {
    func update(_ result: Result<Data, DataError>?) {
        self.willChangeValue(forKey: Operation.isFinishedKey)
        self.willChangeValue(forKey: Operation.isExecutingKey)

        self.result = result

        self.didChangeValue(forKey: Operation.isExecutingKey)
        self.didChangeValue(forKey: Operation.isFinishedKey)
    }
}
