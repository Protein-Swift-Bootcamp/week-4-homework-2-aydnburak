//
//  MovieService.swift
//  week-4-homework-2
//
//  Created by Burak on 3.01.2023.
//

import Foundation

final class MovieService {
    
    
    func downloadMovies(completion: @escaping ([MovieResult]?)->()) {
        
        guard let url = URL(string: APIURLs.movies()) else { return }
        
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
                
            }
            
        }
    }
    
    func downloadDetail(id:Int, completion: @escaping (MovieResult?)->()) {
        
        guard let url = URL(string: APIURLs.detail(id: id)) else { return }
        
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            
            guard let self = self else { return}
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
                
            }
            
        }
    }
    
    private func handleWithError(_ error: Error){
        print(error.localizedDescription)
    }
    
    private func handleWithData(_ data: Data) -> [MovieResult]? {
        do{
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            return movie.results
            
        }catch{
            print(error)
            return nil
        }
    }
    
    private func handleWithData(_ data: Data) -> MovieResult? {
        do{
            return try JSONDecoder().decode(MovieResult.self, from: data)
        }catch{
            print(error)
            return nil
        }
    }
    
  
}
