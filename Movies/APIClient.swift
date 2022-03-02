//
//  APIClient.swift
//  Movies
//
//  Created by Gwinyai Nyatsoka on 23/2/2022.
//

import Foundation

class APIClient {
    
    static let shared = APIClient()
    let baseURL: String = "https://api.themoviedb.org/3/"
    let baseImageURL: String = "https://image.tmdb.org/t/p/w500"
    let apiKey = ""
    
    private init() {}
    
}
