//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Farid Ramos on 1/9/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    
    var refreshData: UIRefreshControl!
    
    override func viewDidLoad() {
        
        activityLoader.startAnimating()
        super.viewDidLoad()
        refreshData = UIRefreshControl()
        refreshData.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshData, at: 0)
        tableView.dataSource = self
        fetchData()
    }
    
    @objc func didPullToRefresh(_ refreshData: UIRefreshControl) {
        fetchData()
    }
    
    func fetchData() {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        cell.movie = movies[indexPath.row]
 
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            let dvc = segue.destination as! DetailViewController
            dvc.movie = movie
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
