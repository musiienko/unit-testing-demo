//
//  MovieRequestMaker.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

protocol MovieRequestMaking {

    func makeGetMoviesRequest(searchTerm: String) -> Request
    func makeDetailsRequest(id: String) -> Request
}

struct MovieRequestMaker: MovieRequestMaking {

    func makeGetMoviesRequest(searchTerm: String) -> Request {
        self.makeRequest(key: "s", value: searchTerm)
    }

    func makeDetailsRequest(id: String) -> Request {
        self.makeRequest(key: "i", value: id)
    }

    private func makeRequest(key: String, value: String) -> Request {

        Request(
            method: "get",
            baseURLString: "http://www.omdbapi.com/?",
            path: "",
            parameters: ["apikey": "<insert your api key>", key: value]
        )
    }
}
