//
//  MovieManager.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

protocol MovieManaging {

    func getMovies(searchTerm: String, completion: @escaping ResultHandler<[MovieModel], Error>)
    func deleteMovie(_ movie: MovieModel, completion: @escaping ResultHandler<Void, Error>)
}

final class MovieManager: MovieManaging {

    // MARK: - Private properties

    private let provider: MovieProviding
    private let mapper: MovieMapping
    private let scheduler: Scheduler

    // MARK: - Init

    init(provider: MovieProviding, mapper: MovieMapping, scheduler: Scheduler) {

        self.provider = provider
        self.mapper = mapper
        self.scheduler = scheduler
    }

    // MARK: - API

    func getMovies(searchTerm: String, completion: @escaping ResultHandler<[MovieModel], Error>) {

        self.provider.getMovies(searchTerm: searchTerm) { [weak self] result in
            self?.handleGetMoviesResult(result, completion: completion)
        }
    }

    private func handleGetMoviesResult(
        _ result: Result<[MovieAPIModel], Error>,
        completion: @escaping ResultHandler<[MovieModel], Error>
    ) {

        let result = result.map { $0.map(self.mapper.toModel(from:)) }
        self.scheduler.schedule {
            completion(result)
        }
    }

    func deleteMovie(_ movie: MovieModel, completion: @escaping ResultHandler<Void, Error>) {

        self.scheduler.schedule {
            completion(.success(()))
        }
    }
}
