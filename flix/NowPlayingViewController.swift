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
    
    var movies: [[String: Any]] = []
    
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
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let movies = dataDictionary["results"] as! [[String: Any]]
                
                self.movies = movies
                
                self.tableView.reloadData()
                
                self.refreshData.endRefreshing()
                self.activityLoader.stopAnimating()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.movieTitle.text = title
        cell.movieOverview.text = overview
        
        let movieImage = movie["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let url = URL(string: baseURL + movieImage)!
        
        cell.movieImg.af_setImage(withURL: url)
        
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
