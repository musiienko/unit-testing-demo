//
//  MovieService.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

protocol MovieProviding {

    func getMovies(searchTerm: String, completion: @escaping ResultHandler<[MovieAPIModel], Error>)
    func getDetailsForMovie(withId id: String, completion: @escaping ResultHandler<MovieDetailsAPIModel, Error>)
}

final class MovieService: MovieProviding {

    // MARK: - Private properties

    private let networkService: NetworkServiceProtocol
    private let requestMaker: MovieRequestMaking

    // MARK: - Init

    init(networkService: NetworkServiceProtocol, requestMaker: MovieRequestMaking) {

        self.networkService = networkService
        self.requestMaker = requestMaker
    }

    func getMovies(searchTerm: String, completion: @escaping ResultHandler<[MovieAPIModel], Error>) {

        let request = self.requestMaker.makeGetMoviesRequest(searchTerm: searchTerm)
        self.networkService.performRequest(request) { (result: Result<MovieSearchResultAPIModel, NetworkError>) in
            completion(result.map { $0.search }.mapError { $0 })
        }
    }

    func getDetailsForMovie(withId id: String, completion: @escaping ResultHandler<MovieDetailsAPIModel, Error>) {

        let request = self.requestMaker.makeDetailsRequest(id: id)
        self.networkService.performRequest(request) { result in
            completion(result.mapError { $0 })
        }
    }
}
