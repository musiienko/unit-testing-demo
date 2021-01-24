//
//  RequestPerforming+URLSession.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

private struct UnknownError: Error { }

protocol RequestPerforming {

    func executeRequest(_ request: URLRequest, completion: @escaping ResultHandler<Data, Error>)
    func cancelRequest(_ request: URLRequest)
}

extension URLSession: RequestPerforming {

    func executeRequest(_ request: URLRequest, completion: @escaping ResultHandler<Data, Error>) {

        let task = self.dataTask(with: request) { (data, response, error) in

            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(UnknownError()))
            }
        }

        task.resume()
    }

    func cancelRequest(_ request: URLRequest) {

    }
}
