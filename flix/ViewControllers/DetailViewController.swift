//
//  DetailViewController.swift
//  flix
//
//  Created by Farid Ramos on 1/17/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            overviewLabel.text = movie["overview"] as? String
            
            let backdropPathString = movie["backdrop_path"] as! String
            let posterPathString = movie["poster_path"] as! String
            
            let baseURL = "https://image.tmdb.org/t/p/w500"

            let backdropURL = URL(string: baseURL + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            
            let posterURL = URL(string: baseURL + posterPathString)!
            posterImageView.af_setImage(withURL: posterURL)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
