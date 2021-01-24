//
//  MockRequestPerformer.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation
@testable import UnitTestingDemo

final class MockRequestPerformer: Mocking, RequestPerforming {

    enum Action: Equatable {

        case executeRequest
        case cancelRequest
    }

    private(set) var actions: [Action] = []

    var executeRequestResult: Result<Data, Error> = .success(Data())

    func executeRequest(_ request: URLRequest, completion: @escaping ResultHandler<Data, Error>) {

        self.actions.append(.executeRequest)
        completion(self.executeRequestResult)
    }

    func cancelRequest(_ request: URLRequest) {
        self.actions.append(.cancelRequest)
    }
}
