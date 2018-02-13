//
//  MovieCell.swift
//  flix
//
//  Created by Farid Ramos on 1/11/18.
//  Copyright © 2018 Farid Ramos. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    var movie: Movie! {
        didSet {
            movieOverview.text = movie.overview
            movieTitle.text = movie.title
            movieImg.af_setImage(withURL: movie.posterURL!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
