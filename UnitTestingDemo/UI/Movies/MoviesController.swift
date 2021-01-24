//
//  MoviesController.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

final class MoviesController: MoviesControlling {

    // MARK: - Public properties

    weak var view: MoviesViewing?

    // MARK: - Private properties

    private let manager: MovieManaging

    // MARK: - Init

    init(manager: MovieManaging) {
        self.manager = manager
    }

    func searchMovies(term: String) {

        self.view?.handleStartLoading()

        self.manager.getMovies(searchTerm: term) { [weak self] result in
            self?.handleSearchResult(result)
        }
    }

    private func handleSearchResult(_ result: Result<[MovieModel], Error>) {

        self.view?.handleStopLoading()

        switch result {
        case .success(let models):
            self.view?.handleReloadDataSuccess(models)
        case .failure(let error):
            self.view?.handleReloadDataFailure(error.localizedDescription)
        }
    }

    func deleteMovie(_ movie: MovieModel) {

        self.manager.deleteMovie(movie) { [weak self] result in
            self?.handleDeleteResult(result: result, of: movie)
        }
    }

    private func handleDeleteResult(result: Result<Void, Error>, of movie: MovieModel) {

        switch result {
        case .success:
            self.view?.handleDeleteSuccess(movie)
        case .failure(let error):
            self.view?.handleDeleteFailure(error.localizedDescription)
        }
    }
}
