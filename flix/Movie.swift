//
//  Movie.swift
//  flix
//
//  Created by Farid Ramos on 2/12/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import Foundation

class Movie {
    let baseURL = "https://image.tmdb.org/t/p/w500"
    var title: String
    var overview: String
    var posterURL: URL?
    var posterPath: String
    var backDropPath: String
    var backdropURL: URL?
    var releaseDate: String
    
    init(dictionary: [String: Any]) {
        title = (dictionary["title"] as? String)!
        overview = (dictionary["overview"] as? String)!
        posterPath = dictionary["poster_path"] as! String
        posterURL = URL(string: baseURL + posterPath)!
        backDropPath = dictionary["backdrop_path"] as! String
        backdropURL = URL(string: baseURL + backDropPath)!
        releaseDate = (dictionary["release_date"] as? String)!
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
