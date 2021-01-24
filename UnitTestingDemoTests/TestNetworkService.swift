//
//  TestNetworkService.swift
//  UnitTestingDemoTests
//
//  Created by Maksym Musiienko on 26.11.20.
//

import XCTest
@testable import UnitTestingDemo

final class TestNetworkService: XCTestCase {

    private struct FakeModel: Codable, Equatable {
        let x: Int
    }

    // MARK: - Private properties

    private var performer: MockRequestPerformer!
    private var transformer: MockRequestTransformer!
    private var decoder: MockDecoder!

    private let fakeModel = FakeModel(x: 5)

    private var sut: NetworkService!

    // MARK: - Life cycle

    override func setUp() {
        super.setUp()

        self.performer = .init()
        self.transformer = .init()
        self.decoder = .init()

        self.sut = .init(
            requestPerformer: self.performer,
            requestTransformer: self.transformer,
            decoder: self.decoder
        )
    }

    // MARK: - Tests

    func testPerformRequestSuccess() {

        self.performer.executeRequestResult = .success(Data())
        self.transformer.makeURLRequestResult = .success(URLRequest(url: URL(string: "https://google.com")!))
        self.decoder.decodeResult = .success(self.fakeModel)

        let request = Request(method: "", baseURLString: "", parameters: [:])

        self.sut.performRequest(request) { [unowned self] (result: Result<FakeModel, NetworkError>) in

            self.assertSuccess(value: self.fakeModel, in: result)
            self.assertEqualActions(in: self.performer, with: [.executeRequest])
            self.assertEqualActions(in: self.transformer, with: [.makeURLRequest])
            self.assertEqualActions(in: self.decoder, with: [.decode])
        }
    }

    func testPerformRequestTransformerFailure() {

        self.performer.executeRequestResult = .success(Data())
        self.transformer.makeURLRequestResult = .failure(.malformedBaseURL)
        self.decoder.decodeResult = .success(self.fakeModel)

        let request = Request(method: "", baseURLString: "", parameters: [:])

        self.sut.performRequest(request) { [unowned self] (result: Result<FakeModel, NetworkError>) in

            self.assertFailure(error: .request(.malformedBaseURL), in: result)
            self.assertEqualActions(in: self.performer, with: [])
            self.assertEqualActions(in: self.transformer, with: [.makeURLRequest])
            self.assertEqualActions(in: self.decoder, with: [])
        }
    }

    func testPerformRequestDecodingFailure() {

        self.performer.executeRequestResult = .success(Data())
        self.transformer.makeURLRequestResult = .success(URLRequest(url: URL(string: "https://google.com")!))
        self.decoder.decodeResult = .failure(NSError(domain: "123", code: 1, userInfo: nil))

        let request = Request(method: "", baseURLString: "", parameters: [:])

        self.sut.performRequest(request) { [unowned self] (result: Result<FakeModel, NetworkError>) in

            self.assertFailure(error: .decoding, in: result)
            self.assertEqualActions(in: self.performer, with: [.executeRequest])
            self.assertEqualActions(in: self.transformer, with: [.makeURLRequest])
            self.assertEqualActions(in: self.decoder, with: [.decode])
        }
    }
}
