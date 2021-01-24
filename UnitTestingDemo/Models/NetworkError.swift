//
//  NetworkError.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

enum NetworkError: Error, Equatable {

    case decoding
    case request(RequestError)
    case other(Error)
    case unknown

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {

        switch (lhs, rhs) {
        case (.decoding, .decoding):
            return true
        case (.request(let lhsError), .request(let rhsError)):
            return lhsError == rhsError
        case (.other, .other):
            return true
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
