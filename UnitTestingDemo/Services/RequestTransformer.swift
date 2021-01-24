//
//  RequestTransformer.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

enum RequestError: Error, Equatable {

    case malformedBaseURL
    case urlCreationIsNotPossible
}

protocol RequestTransforming {

    func makeURLRequest(request: Request) -> Result<URLRequest, RequestError>
}

final class RequestTransformer: RequestTransforming {

    func makeURLRequest(request: Request) -> Result<URLRequest, RequestError> {

        guard var components = URLComponents(string: request.baseURLString) else {
            return .failure(.malformedBaseURL)
        }

        components.path = request.path
        components.queryItems = request.parameters.map(URLQueryItem.init)

        guard let url = components.url else {
            return .failure(.urlCreationIsNotPossible)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        return .success(urlRequest)
    }
}
