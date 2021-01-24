//
//  SceneDelegate.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else {
            return
        }

        let window = UIWindow(windowScene: scene)
        window.rootViewController = UINavigationController(rootViewController: self.makeInitialViewController())
        window.makeKeyAndVisible()
        self.window = window
    }

    private func makeInitialViewController() -> UIViewController {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .custom { keys -> CodingKey in

            let key = keys.last!.stringValue
            return MyCodingKey(stringValue: "\(key.first!.lowercased())\(key.dropFirst())")!
        }

        let networkService = NetworkService(
            requestPerformer: URLSession.shared,
            requestTransformer: RequestTransformer(),
            decoder: decoder
        )

        let service = MovieService(
            networkService: networkService,
            requestMaker: MovieRequestMaker()
        )

        let manager = MovieManager(
            provider: service,
            mapper: MovieMapper(),
            scheduler: DispatchQueue.main
        )

        let controller = MoviesController(manager: manager)

        return MoviesViewController.create(
            controller: controller,
            tableViewHandler: MoviesTableViewHandler()
        )
    }
}
