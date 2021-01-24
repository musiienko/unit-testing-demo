//
//  MoviesProtocols.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

protocol MoviesViewing: class {

    func handleStartLoading()
    func handleStopLoading()
    
    func handleReloadDataSuccess(_ items: [MovieModel])
    func handleReloadDataFailure(_ error: String)
    func handleDeleteSuccess(_ movie: MovieModel)
    func handleDeleteFailure(_ error: String)
}

protocol MoviesControlling: class {

    var view: MoviesViewing? { get set }

    func searchMovies(term: String)
    func deleteMovie(_ movie: MovieModel)
}
