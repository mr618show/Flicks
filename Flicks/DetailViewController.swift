//
//  DetailViewController.swift
//  Flicks
//
//  Created by Rui Mao on 3/30/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    var movie: NSDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
    
        let title = movie["title"] as? String
        titleLabel.text = title
        let overview = movie["overview"] as?
            String
        overviewLabel.text = overview
        print(movie)
        overviewLabel.sizeToFit()
        
        let baseurl = "https://image.tmdb.org/t/p/w500/"
        if let posterPath = movie["poster_path"] as? String{
            let imageUrl = NSURL(string: baseurl + posterPath)
            posterImageView.setImageWith(imageUrl! as URL)
            /*posterImageView.setImageWith(imageUrl! as URL, placeholderImage: nil, success: { (imageUrl, imageResponse, image) -> Void in
                if imageResponse != nil {
                    print ("Image was Not cashed, fade in image")
                    self.posterImageView.alpha = 0.0
                    self.posterImageView.image = image
                    UIView.animate(withDuration: 0.3 , animations: {<#T##() -> Void#>in self.posterImageView.alpha = 1.0})
                }
                else {
                    print ("Image was cased so just update the image")
                    self.posterImageView.image = image
                }
                
            }, failure: { (imageUrl, imageResponse, image) in
                self.posterImageView.image = image
            }) */
        }
        else {
            self.posterImageView.image = nil
        }

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
