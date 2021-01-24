//
//  MockMovieRequestMaker.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation
@testable import UnitTestingDemo

final class MockMovieRequestMaker: MovieRequestMaking, Mocking {

    enum Action: Equatable {

        case makeGetMoviesRequest
        case makeDetailsRequest
    }

    private(set) var actions: [Action] = []

    func makeGetMoviesRequest(searchTerm: String) -> Request {

        self.actions.append(.makeGetMoviesRequest)
        return self.makeRequest()
    }

    func makeDetailsRequest(id: String) -> Request {

        self.actions.append(.makeDetailsRequest)
        return self.makeRequest()
    }

    private func makeRequest() -> Request {
        Request(method: "", baseURLString: "'", path: "", parameters: [:])
    }
}
