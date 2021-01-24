//
//  MovieModels.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

// MARK: - API

struct MovieSearchResultAPIModel: Decodable, Equatable {

    let search: [MovieAPIModel]
}

struct MovieAPIModel: Decodable, Equatable {

    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String?
}

// MARK: - Presentation

enum MovieType: String, Equatable {
    case movie, series, unknown
}

struct MovieModel: Equatable {

    let title: String
    let year: String
    let type: MovieType
    let posterURL: String?
}

struct MovieDetailsAPIModel: Decodable {

    let details: String
}
