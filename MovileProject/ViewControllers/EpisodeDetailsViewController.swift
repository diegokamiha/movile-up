//
//  EpisodeDetailsViewController.swift
//  MovileProject
//
//  Created by iOS on 7/16/15.
//
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var imageEpisode: UIImageView!
    
    @IBOutlet weak var titleEpisode: UILabel!
    
    @IBOutlet weak var textEpisode: UITextView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
