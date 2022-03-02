//
//  PopularMoviesService.swift
//  Movies
//
//  Created by Gwinyai Nyatsoka on 28/2/2022.
//

import Foundation

class PopularMovieService {
    
    static let shared = PopularMovieService()
    let movieSession = URLSession(configuration: .default)
    var parameters = ["api_key": ""]
    let headers = ["Accept": "application/json", "Content-Type": "application/json"]
    private init() {}
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie],Error>) -> ()) {
        parameters["page"] = "\(page)"
        do {
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .getPopularMovies, with: parameters, includes: headers, and: .get)
            movieSession.dataTask(with: request) { data, res, error in
                if let response = res as? HTTPURLResponse,
                   let unwrappedData = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let movies = try? JSONDecoder().decode(Movies.self, from: unwrappedData)
                        completion(Result.success(movies!.movies))
                    case .failure:
                        completion(Result.failure(HTTPNetworkingError.decodingFailed))
                    }
                }
            }.resume()
        } catch {
            completion(Result.failure(HTTPNetworkingError.badRequest))
        }
    }
    
    
}
