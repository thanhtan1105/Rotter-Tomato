//
//  ViewController.swift
//  Rotter2
//
//  Created by Le Thanh Tan on 11/9/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper
import Alamofire


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellid : String = "MovieCell"
    var listMovie: Array<MovieModel>?
    var refeshControl: UIRefreshControl!
    
    
    @IBOutlet weak var tableView: UITableView!
    var movies = [NSDictionary]()
    let movieDataURL : String = "https://coderschool-movies.herokuapp.com/movies?api_key=xja087zcvxljadsflh214"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // create RefeshControl
        refeshControl = UIRefreshControl()
        refeshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refeshControl, atIndex: 0)
        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.fetchMovie()
        
        
    }
    
    func fetchMovie() {
        // loading
        CozyLoadingActivity.show("Loading...", disableUI: true) 
        
        let url : NSURL? = NSURL(string: movieDataURL)
        let request : NSURLRequest? = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request!) { (data :NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            guard error == nil else  {
                print("error loading from URL", error!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    CozyLoadingActivity.hide(success: false, animated: true)
                });
                return
            }
            
            let dic = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
            let movieDic = dic["movies"]!
            let theJSONData = try! NSJSONSerialization.dataWithJSONObject(movieDic, options: NSJSONWritingOptions.init(rawValue: 0))
            let movieJSON = try! NSJSONSerialization.JSONObjectWithData(theJSONData, options: .AllowFragments)
            
            self.listMovie = Mapper<MovieModel>().mapArray(movieJSON)
            print(self.listMovie!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                CozyLoadingActivity.hide()
            })
        }
        
        task.resume()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellid) as! MovieCell
        
        if self.listMovie != nil {
            let movie: MovieModel = (self.listMovie?[indexPath.row])!
            cell.title.text = movie.title
            
            // load image
            let URL : NSURL = NSURL(string: (movie.poster?.thumbnailURL)!)!
            cell.imageView?.image = UIImage(data: NSData(contentsOfURL: URL)!)
            
            // get detail
            let detail : String = "\(movie.mpaa_rating) \(movie.synopsis)"
            cell.pgAge.text = detail


        }

        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listMovie?.count) ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView .deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func onRefresh() {
        self.fetchMovie()
        self.refeshControl.endRefreshing()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! VideoDetailViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        vc.movieDetail = (self.listMovie?[(indexPath?.row)!])!
        
    }
}

