//
//  Mocking.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation
@testable import UnitTestingDemo

protocol Mocking {

    associatedtype Action: Equatable

    var actions: [Action] { get }
}

