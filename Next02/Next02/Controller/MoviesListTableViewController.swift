//
//  MoviesListTableViewController.swift
//  Next02
//
//  Created by Valmir Junior on 03/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class MoviesListTableViewController: UITableViewController {
    
    
    // MARK: - Properties
    private var movies: [Movie] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.loadMovies()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentMovie = self.movies[indexPath.row]
        
        if let itemType = currentMovie.itemType {
            switch itemType {
            case .list:
                let cell = tableView.dequeueReusableCell(withIdentifier: "recomendationCell", for: indexPath)
                guard let recomendationCell = cell as? RecomendationTableViewCell else { return cell }
                guard let recomendations = currentMovie.items else { return cell }
                recomendationCell.prepare(with: recomendations)
            
                return recomendationCell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                guard let movieCell = cell as? MovieTableViewCell else { return cell }
                movieCell.prepare(with: currentMovie)
                return movieCell
            }
        }
        
        return UITableViewCell()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // When autolayout does not works in rotation transition.
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    // MARK: - Methods
    private func loadMovies() {
        
        guard let movieData = NSDataAsset(name: "movies")?.data else { return }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            self.movies = try decoder.decode([Movie].self, from: movieData)
            self.tableView.reloadData()
        } catch {
            print(error)
        }
    }

}
