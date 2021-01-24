//
//  MoviesTableViewHandler.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import UIKit

protocol MoviesTableViewHandling {

    var didSelectMovieHandler: Handler<MovieModel>? { get set }

    func setup(for tableView: UITableView)
    func configure(with items: [MovieModel])
}

final class MoviesTableViewHandler: NSObject, MoviesTableViewHandling {

    // MARK: - Public properties

    var didSelectMovieHandler: Handler<MovieModel>?

    // MARK: - Private properties

    private weak var tableView: UITableView?

    private var items: [MovieModel] = []

    // MARK: - Setup

    func setup(for tableView: UITableView) {

        self.tableView = tableView

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Configure

    func configure(with items: [MovieModel]) {

        self.items = items
        self.tableView?.reloadData()
    }

    func deleteMovie(_ movie: MovieModel) {

        guard let index = self.items.firstIndex(of: movie) else {
            return
        }

        self.items.remove(at: index)
        self.tableView?.reloadData()
    }
}

extension MoviesTableViewHandler: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = self.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = "\(model.type) \(model.year)"
        return cell
    }
}

extension MoviesTableViewHandler: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectMovieHandler?(self.items[indexPath.row])
    }
}
