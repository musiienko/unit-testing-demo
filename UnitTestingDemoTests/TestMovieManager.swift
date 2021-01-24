//
//  TestMovieManager.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import XCTest
@testable import UnitTestingDemo

final class TestMovieManager: XCTestCase {

    // MARK: - Private properties

    private var movieService: MockMovieService!
    private var mapper: StubMovieMapper!
    private var scheduler: MockScheduler!

    private var sut: MovieManager!

    // MARK: - Life cycle

    override func setUp() {
        super.setUp()

        self.movieService = .init()
        self.scheduler = .init()
        self.mapper = .init()

        self.sut = .init(
            provider: self.movieService,
            mapper: self.mapper,
            scheduler: self.scheduler
        )
    }

    // MARK: - Tests

    func testGetMoviesSuccess() {

        let apiModel = MovieAPIModel(title: "", year: "", imdbID: "", type: "", poster: nil)

        self.movieService.getMoviesResult = .success([apiModel])

        self.sut.getMovies(searchTerm: "") { [unowned self] result in

            self.assertSuccess(value: [self.mapper.toModel(from: apiModel)], in: result)
            self.assertEqualActions(in: self.movieService, with: [.getMovies])
            self.assertEqualActions(in: self.scheduler, with: [.schedule])
        }
    }
}
