//
//  ViewController.swift
//  week-4-homework-2
//
//  Created by Burak on 2.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let movieService = MovieService()
    
    var movies: [MovieResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        getMovies()
    }
    
    func getMovies() {
        movieService.downloadMovies() { [weak self] returnedMovies in
            guard let self = self else { return }
            guard let returnedMovies = returnedMovies else { return }
            self.movies = returnedMovies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell() }
        
        cell.titleLabel.text = movies[indexPath.row].title ?? "Empty"
        cell.subTitleLabel.text = movies[indexPath.row].releaseDate ?? ""
        cell.downloadImage(movie: movies[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let goVC = storyboard.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        goVC.configure(with: movies[indexPath.row])
        navigationController?.pushViewController(goVC, animated: true)
    }
}
