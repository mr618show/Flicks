//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Rui Mao on 3/28/17.
//  Copyright © 2017 Rui Mao. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]?
    var endpoint: String!
    var filteredMovies: [NSDictionary] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //filteredMovies = (movies?)!
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        
        
        networkRequest()
    }
    
    //print ( (endpoint))
    
    func networkRequest(){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(endpoint!)?api_key=\(apiKey)")
        //let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate:nil,
                                 delegateQueue:OperationQueue.main
        )
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let task : URLSessionDataTask = session.dataTask(with: request as URLRequest,completionHandler: { (dataOrNil, response, error) in
            sleep(1)
            MBProgressHUD.hide(for: self.view, animated: true)
            if let httpError = error {
                print("\(httpError)")
            } else {
                if let data = dataOrNil {
                    if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                        print("response: \(responseDictionary)")
                        self.movies = responseDictionary["results"] as? [NSDictionary]
                        self.tableView.reloadData()
                    }
                }
            }
            
        });
        task.resume()
    }
    // Do any additional setup after loading the view.
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if let movies = movies {
        //return movies.count
        return filteredMovies.count
        // } else {
        //    return 0
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",for: indexPath) as! MovieCell
        cell.backgroundView = UIImageView(image: UIImage(named: "bg.png")!)
        //Disable selection effect when selecting UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        //let movie = movies![indexPath.row]
        let movie = filteredMovies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        let baseurl = "https://image.tmdb.org/t/p/w500/"
        let posterPath = movie["poster_path"] as! String
        
        let imageUrl = NSURL(string: baseurl + posterPath)
        
        cell.posterView.setImageWith(imageUrl! as URL)
        //print("row \(indexPath.row)")
        return cell
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            
            self.filteredMovies = searchText.isEmpty ? self.movies! : self.movies!.filter({
                (movie: NSDictionary) -> Bool in
                // If dataItem matches the searchText, return true to include it
                return (movie["title"] as? String)?.range(of: searchText, options: .caseInsensitive) != nil
            })            
            tableView.reloadData()
            
        }
    } // updateSearchResults
    
    /*
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     // When there is no text, filteredData is the same as the original data
     // When user has entered text into the search box
     // Use the filter method to iterate over all items in the data array
     // For each item, return true if the item should be included and false if the
     // item should NOT be included
     filteredData = searchText.isEmpty ? movies : movies.filter(){ (movie: NSDictionary) -> Bool in
     // If dataItem matches the searchText, return true to include it
     return (movie["title"] as? String)?.range(of: searchText, options: .caseInsensitive) != nil
     }
     
     movieTableView.tableView.reloadData()
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let movie = movies![indexPath!.row]
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        
        
        print ("prepare for segue called")
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}


