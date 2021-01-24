//
//  MovieMapper.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

protocol MovieMapping {

    func toModel(from apiModel: MovieAPIModel) -> MovieModel
}

struct MovieMapper: MovieMapping {

    func toModel(from apiModel: MovieAPIModel) -> MovieModel {

        MovieModel(
            title: apiModel.title,
            year: apiModel.year,
            type: MovieType(rawValue: apiModel.type) ?? .unknown,
            posterURL: apiModel.poster
        )
    }
}
