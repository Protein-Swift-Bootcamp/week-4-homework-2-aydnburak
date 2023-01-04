//
//  MovieTableViewCell.swift
//  week-4-homework-2
//
//  Created by Burak on 3.01.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let reuseID = "MovieTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    private var dataTask: URLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func downloadImage(movie: MovieResult){
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie.posterPath ?? "")) else { return }
        
        dataTask = NetworkManager.shared.download(url: url, completion: { [weak self] result in
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
        })
        
        dataTask?.resume()
    }
    
}
