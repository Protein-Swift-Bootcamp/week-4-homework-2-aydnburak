//
//  APIURLs.swift
//  week-4-homework-2
//
//  Created by Burak on 3.01.2023.
//

import Foundation

final class APIURLs {
    private init(){}
    
    static func movies() -> String {
        "https://api.themoviedb.org/3/movie/popular?api_key=685a651565a761e57d0023460c2c6cf3&language=en-US"
    }
    
    static func detail(id: Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)?api_key=685a651565a761e57d0023460c2c6cf3&language=en-US"
    }

    static func imageURL(posterPath: String) -> String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
}
