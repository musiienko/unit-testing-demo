//
//  TestMovieService.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import XCTest
@testable import UnitTestingDemo

final class TestMovieService: XCTestCase {

    // MARK: - Private properties

    private var networkService: MockNetworkService!
    private var requestMaker: MockMovieRequestMaker!
    private var sut: MovieService!

    // MARK: - Life cycle

    override func setUp() {
        super.setUp()

        self.networkService = .init()
        self.requestMaker = .init()
        self.sut = .init(networkService: self.networkService, requestMaker: self.requestMaker)
    }

    // MARK: - Tests

    func testGetMoviesSuccess() {

        let movieApiModel = MovieAPIModel(title: "1", year: "2", imdbID: "3", type: "movie", poster: nil)
        let apiModel = MovieSearchResultAPIModel(search: [movieApiModel])
        self.networkService.performRequestResult = .success(apiModel)

        self.sut.getMovies(searchTerm: "something") { [unowned self] result in
            
            self.assertSuccess(value: apiModel.search, in: result)
            self.assertEqualActions(in: self.networkService, with: [.performRequest])
            self.assertEqualActions(in: self.requestMaker, with: [.makeGetMoviesRequest])
        }
    }

    func testGetMoviesFailure() {

        self.networkService.performRequestResult = .failure(.request(.urlCreationIsNotPossible))

        self.sut.getMovies(searchTerm: "something") { [unowned self] result in

            self.assertFailure(error: NetworkError.request(.urlCreationIsNotPossible), in: result)
            self.assertEqualActions(in: self.networkService, with: [.performRequest])
            self.assertEqualActions(in: self.requestMaker, with: [.makeGetMoviesRequest])
        }
    }
}
