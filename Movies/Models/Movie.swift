//
//  Movie.swift
//  Movies
//
//  Created by Gwinyai Nyatsoka on 23/2/2022.
//

import Foundation

//original_title

struct Movie: Codable {
    
    var movieTitle: String
    var movieDescription: String
    var movieImage: String?
    
    enum CodingKeys: String, CodingKey {
        case movieTitle = "original_title"
        case movieDescription = "overview"
        case movieImage = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movieTitle = try values.decode(String.self, forKey: .movieTitle)
        movieDescription = try values.decode(String.self, forKey: .movieDescription)
        if let posterPath = try values.decodeIfPresent(String.self, forKey: .movieImage) {
            movieImage = APIClient.shared.baseImageURL + posterPath
        }
    }
    
}

struct Movies: Codable {
    
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
}
