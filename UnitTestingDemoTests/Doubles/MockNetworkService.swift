//
//  MockNetworkService.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation
@testable import UnitTestingDemo

final class MockNetworkService: NetworkServiceProtocol, Mocking {

    enum Action: Equatable {
        case performRequest
    }

    private(set) var actions: [Action] = []

    var performRequestResult: Result<Decodable, NetworkError> = .failure(.unknown)

    func performRequest<T: Decodable>(_ request: Request, completion: @escaping ResultHandler<T, NetworkError>) {

        self.actions.append(.performRequest)
        completion(self.performRequestResult.map { $0 as! T })
    }
}
