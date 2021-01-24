//
//  StubMovieMapper.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 27.11.20.
//

import Foundation
@testable import UnitTestingDemo

struct StubMovieMapper: MovieMapping {

    func toModel(from apiModel: MovieAPIModel) -> MovieModel {
        MovieModel(title: "", year: "", type: .movie, posterURL: nil)
    }
}
