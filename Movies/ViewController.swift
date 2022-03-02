//
//  ViewController.swift
//  Movies
//
//  Created by Gwinyai Nyatsoka on 23/2/2022.
//

import UIKit
import SDWebImage

/*
 
 {
    page: 1,
    results: {
        {
            movie_title
            poster_path
        }
    }
 
 */

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie] = [Movie]()
    var page: Int = 1
    var isFetching = false
    var isBouncing = false
    var didLoad = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetch(page: 1)
    }
    
    func fetch(page: Int) {
        isFetching = true
        PopularMovieService.shared.getPopularMovies(page: page) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movies):
                if movies.count >= 20 {
                    strongSelf.page = page
                }
                strongSelf.movies += movies
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                let alert = ReportError.shared.getAlert(title: "Error", message: "Failed to get movies")
                DispatchQueue.main.async {
                    strongSelf.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.movieTitleLabel.text = movie.movieTitle
        cell.movieDescriptionLabel.text = movie.movieDescription
        if let posterPath = movie.movieImage,
           let movieURL = URL(string: posterPath) {
            cell.movieImageView.sd_setImage(with: movieURL, completed: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > tableView.contentSize.height - 50 - scrollView.frame.size.height {
            guard !isFetching else { return }
            guard !isBouncing else { return }
            guard didLoad else { return }
            isBouncing = true
            fetch(page: page + 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isBouncing = false
            }
        }
    }
    
}



