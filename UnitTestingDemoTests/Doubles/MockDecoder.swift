//
//  MockDecoder.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation
@testable import UnitTestingDemo

final class MockDecoder: Mocking, Decoder {

    enum Action: Equatable {
        case decode
    }

    private(set) var actions: [Action] = []

    var decodeResult: Result<Decodable, Error>!

    func decode<T: Decodable>(data: Data) -> Result<T, Error> {

        self.actions.append(.decode)
        return self.decodeResult.map { $0 as! T }
    }
}
