//
//  DetailViewController.swift
//  week-4-homework-2
//
//  Created by Burak on 4.01.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(with movie: MovieResult){
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title ?? ""
            self.dateLabel.text = movie.releaseDate ?? ""
            self.descLabel.text = movie.overview ?? ""
        }
        downloadImage(movie: movie)
    }
    
    func downloadImage(movie: MovieResult){
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie.posterPath ?? "")) else { return }
        
        NetworkManager.shared.download(url: url, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.movieImage.image = UIImage(data: data)
                }
                break
            case .failure(_):
                break
            }
        }).resume()
    }
}
