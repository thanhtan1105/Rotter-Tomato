//
//  VideoDetailViewController.swift
//  Rotter2
//
//  Created by Le Thanh Tan on 11/15/15.
//  Copyright © 2015 Le Thanh Tan. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {

    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var titles: UILabel!
    var position: Bool = false
    var movieDetail: MovieModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = movieDetail.title!
        self.contentView.hidden = true
        
        let gesture = UITapGestureRecognizer(target: self, action: "fingerTapView")
        self.contentView.addGestureRecognizer(gesture)
        
        CozyLoadingActivity.show("Loading...", disableUI: true)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            // load image
            let URL : NSURL = NSURL(string: (self.movieDetail.poster?.detailedURL)!)!
            
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageViews?.image = UIImage(data: NSData(contentsOfURL: URL)!)
                self.titles.text = "\(self.movieDetail.title!) \(self.movieDetail.mpaa_rating!)"
                self.synopsis.text = self.movieDetail.synopsis!
                self.contentView.hidden = false
                CozyLoadingActivity.hide()
            });
        }
    }

    func fingerTapView() {
        if position {
            // contentView is on original position
            let height = UIScreen.mainScreen().bounds.height
            let width = UIScreen.mainScreen().bounds.width
            let rect = CGRectMake(0, height - 200, width, height)
            
            UIView.animateWithDuration(1.0,
                delay: 0.0,
                options: .CurveEaseInOut,
                animations: {
                    self.contentView.frame = rect
                },
                completion: { finished in
                    self.position = false
            })

            
        } else {
            // contentView is full screen
            let height = UIScreen.mainScreen().bounds.height
            let width = UIScreen.mainScreen().bounds.width
            let rect = CGRectMake(0, 60, width, height)

            UIView.animateWithDuration(1.0,
                delay: 0.0,
                options: .CurveEaseInOut,
                animations: {
                    self.contentView.frame = rect
                },
                completion: { finished in
                    self.position = true
            })
        }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
