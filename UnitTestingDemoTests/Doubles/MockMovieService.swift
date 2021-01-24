//
//  MockMovieService.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 27.11.20.
//

import Foundation
@testable import UnitTestingDemo

final class MockMovieService: MovieProviding, Mocking {

    enum Action: Equatable {

        case getMovies
        case getDetailsForMovie
    }

    private(set) var actions: [Action] = []

    var getMoviesResult: Result<[MovieAPIModel], Error> = .success([])
    var getDetailsForMovieResult: Result<MovieDetailsAPIModel, Error> = .success(.init(details: ""))

    func getMovies(searchTerm: String, completion: @escaping ResultHandler<[MovieAPIModel], Error>) {

        self.actions.append(.getMovies)
        completion(self.getMoviesResult)
    }

    func getDetailsForMovie(withId id: String, completion: @escaping ResultHandler<MovieDetailsAPIModel, Error>) {

        self.actions.append(.getDetailsForMovie)
        completion(self.getDetailsForMovieResult)
    }
}
