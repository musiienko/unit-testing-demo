//
//  NetworkService.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

typealias VoidHandler = () -> Void
typealias Handler<T> = (T) -> Void
typealias ResultHandler<T, E: Error> = Handler<Result<T, E>>

protocol NetworkServiceProtocol {

    func performRequest<T: Decodable>(_ request: Request, completion: @escaping ResultHandler<T, NetworkError>)
}

final class NetworkService: NetworkServiceProtocol {

    // MARK: - Private properties

    private let performer: RequestPerforming
    private let transformer: RequestTransforming
    private let decoder: Decoder

    // MARK: - Init

    init(
        requestPerformer: RequestPerforming,
        requestTransformer: RequestTransforming,
        decoder: Decoder
    ) {

        self.performer = requestPerformer
        self.transformer = requestTransformer
        self.decoder = decoder
    }

    // MARK: - API

    func performRequest<T: Decodable>(
        _ request: Request,
        completion: @escaping ResultHandler<T, NetworkError>
    ) {

        switch self.transformer.makeURLRequest(request: request) {
        case .success(let request):
            self.performRequest(request, completion: completion)
        case .failure(let error):
            completion(.failure(.request(error)))
        }
    }

    private func performRequest<T: Decodable>(
        _ request: URLRequest,
        completion: @escaping ResultHandler<T, NetworkError>
    ) {

        self.performer.executeRequest(request) { [unowned self] result in

            let result: Result<T, NetworkError> = result
                .mapError(NetworkError.other)
                .flatMap { self.decoder.decode(data: $0).mapError { _ in .decoding } }
            completion(result)
        }
    }
}
