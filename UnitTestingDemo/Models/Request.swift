//
//  Request.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

struct Request {

    let method: String
    let baseURLString: String
    private(set) var path: String = ""
    private(set) var parameters: [String: String?] = [:]
}
