//
//  XCTest+Extensions.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import XCTest
@testable import UnitTestingDemo

// MARK: - Assert Result

extension XCTest {

    func assertSuccess<Success, Failure: Error>(in result: Result<Success, Failure>, fulfill expectation: XCTestExpectation? = nil, file: StaticString = #file, line: UInt = #line) {

        expectation?.fulfill()

        switch result {
        case .success:
            break
        case .failure(let error):
            XCTFail("Expected Success; Received: \(error)", file: file, line: line)
        }
    }

    func assertFailure<Success, Failure: Error>(in result: Result<Success, Failure>, fulfill expectation: XCTestExpectation? = nil, file: StaticString = #file, line: UInt = #line) {

        expectation?.fulfill()

        switch result {
        case .success:
            XCTFail("Expected Failure", file: file, line: line)
        case .failure:
            break
        }
    }

    func assertSuccess<Success: Equatable, Failure: Error>(
        value expectedValue: Success?,
        in result: Result<Success, Failure>,
        fulfill expectation: XCTestExpectation? = nil,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {

        expectation?.fulfill()

        switch result {
        case .success(let value):
            XCTAssertEqual(value, expectedValue, message(), file: file, line: line)
        case .failure:
            XCTFail("Expected Success", file: file, line: line)
        }
    }

    func assertFailure<Success, Failure: Error & Equatable>(
        error expectedError: Failure?,
        in result: Result<Success, Failure>,
        fulfill expectation: XCTestExpectation? = nil,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {

        expectation?.fulfill()

        switch result {
        case .success:
            XCTFail("Expected Failure", file: file, line: line)
        case .failure(let error):
            XCTAssertEqual(error, expectedError, message(), file: file, line: line)
        }
    }

    func assertFailure<Success, Failure: Error & Equatable>(
        error expectedError: Failure?,
        in result: Result<Success, Error>,
        fulfill expectation: XCTestExpectation? = nil,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {

        expectation?.fulfill()

        switch result {
        case .success:
            XCTFail("Expected Failure", file: file, line: line)
        case .failure(let error):
            XCTAssertEqual(error as? Failure, expectedError, message(), file: file, line: line)
        }
    }
}

// MARK: - Assert Equal Actions

extension XCTest {

    func assertEqualActions<T: Mocking>(
        in mock: T,
        with expectedActions: [T.Action],
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(mock.actions, expectedActions, message(), file: file, line: line)
    }
}

// MARK: - Expectations

extension XCTestCase {

    func createExpectationAndPerform(
        timeout: TimeInterval = 2,
        description: String = "Async Operation",
        action: @escaping Handler<XCTestExpectation>
    ) {

        let expectation = XCTestExpectation(description: description)
        action(expectation)
        self.wait(for: [expectation], timeout: timeout)
    }
}

extension XCTest {

    func fulfillExpectation<Value: Equatable>(
        _ expectation: XCTestExpectation,
        ifExpected expectedValue: Value,
        equalTo givenValue: Value,
        _ message: @autoclosure () -> String = "Values are not equal",
        file: StaticString = #file,
        line: UInt = #line
    ) {

        self.fulfillExpectation(expectation, onCondition: expectedValue == givenValue, message(), file: file, line: line)
    }

    func fulfillExpectation<Value: Equatable>(
        _ expectation: XCTestExpectation,
        ifExpected expectedValue: Value,
        notEqualTo givenValue: Value,
        _ message: @autoclosure () -> String = "Values are not equal",
        file: StaticString = #file,
        line: UInt = #line
    ) {

        self.fulfillExpectation(expectation, onCondition: expectedValue != givenValue, message(), file: file, line: line)
    }

    private func fulfillExpectation(
        _ expectation: XCTestExpectation,
        onCondition condition: @autoclosure () -> Bool,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) {

        if condition() {
            expectation.fulfill()
        } else {
            XCTFail(message(), file: file, line: line)
        }
    }
}
