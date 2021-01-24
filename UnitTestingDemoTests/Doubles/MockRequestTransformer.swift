//
//  MockRequestTransformer.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation
@testable import UnitTestingDemo

final class MockRequestTransformer: RequestTransforming, Mocking {

    enum Action: Equatable {
        case makeURLRequest
    }

    private(set) var actions: [Action] = []

    var makeURLRequestResult: Result<URLRequest, RequestError>!

    func makeURLRequest(request: Request) -> Result<URLRequest, RequestError> {

        self.actions.append(.makeURLRequest)
        return self.makeURLRequestResult
    }
}
