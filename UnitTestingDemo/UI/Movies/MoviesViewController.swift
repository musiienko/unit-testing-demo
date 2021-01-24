//
//  MoviesViewController.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import UIKit

final class MoviesViewController: UIViewController {

    // MARK: - Private properties

    private var controller: MoviesControlling!
    private var tableViewHandler: MoviesTableViewHandling!

    // MARK: - Outlets

    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!

    static func create(
        controller: MoviesControlling,
        tableViewHandler: MoviesTableViewHandling
    ) -> MoviesViewController {

        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MoviesViewController") as! MoviesViewController

        viewController.controller = controller
        controller.view = viewController

        viewController.tableViewHandler = tableViewHandler

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewHandler.setup(for: self.tableView)
        self.controller.searchMovies(term: "something interesting")
    }
}

// MARK: - MoviesViewing

extension MoviesViewController: MoviesViewing {

    func handleStartLoading() {
        self.loadingIndicatorView.startAnimating()
    }

    func handleStopLoading() {
        self.loadingIndicatorView.stopAnimating()
    }

    func handleReloadDataSuccess(_ items: [MovieModel]) {
        self.tableViewHandler.configure(with: items)
    }

    func handleReloadDataFailure(_ error: String) {
        self.presentErrorAlert(withMessage: error)
    }

    func handleDeleteSuccess(_ movie: MovieModel) {

    }

    func handleDeleteFailure(_ error: String) {
        self.presentErrorAlert(withMessage: error)
    }

    private func presentErrorAlert(withMessage message: String) {

        let alert = UIAlertController(title: "oof", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "¯\\_(ツ)_/¯ ", style: .default))
        self.present(alert, animated: true)
    }
}
