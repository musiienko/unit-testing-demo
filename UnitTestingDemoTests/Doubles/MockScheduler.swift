//
//  MockScheduler.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 27.11.20.
//

import Foundation
@testable import UnitTestingDemo

final class MockScheduler: Scheduler, Mocking {

    enum Action: Equatable {
        case schedule
    }

    private(set) var actions: [Action] = []

    func schedule(_ block: @escaping VoidHandler) {

        self.actions.append(.schedule)
        block()
    }
}
