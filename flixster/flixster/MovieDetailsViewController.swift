//
//  MovieDetailsViewController.swift
//  MovieDetailsViewController
//
//  Created by MacBook Pro on 9/19/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    var movie: [String:Any]!
    
    @IBOutlet var backdropView: UIImageView!
    @IBOutlet var posterView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as! String //as? String
        titleLabel.sizeToFit()
        
        let rating = String(format: "Rating \(movie["vote_average"]!) released \(movie["release_date"]!)")
        ratingLabel.text = rating
        ratingLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseUrl + posterPath)
        posterView.af_setImage(withURL: posterURL!)
        
        let baseBackdropUrl = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: baseBackdropUrl + backdropPath)
        backdropView.af_setImage(withURL: backdropURL!)

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
