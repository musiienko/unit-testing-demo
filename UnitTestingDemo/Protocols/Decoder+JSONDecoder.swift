//
//  Decoder+JSONDecoder.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

protocol Decoder {

    func decode<T: Decodable>(data: Data) -> Result<T, Error>
}

extension JSONDecoder: Decoder {

    func decode<T: Decodable>(data: Data) -> Result<T, Error> {

        do {
            return .success(try self.decode(T.self, from: data))
        } catch {
            return .failure(error)
        }
    }
}

struct MyCodingKey: CodingKey {

    let stringValue: String

    var intValue: Int? {
        nil
    }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        nil
    }
}
