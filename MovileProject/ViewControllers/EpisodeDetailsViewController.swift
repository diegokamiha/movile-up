//
//  EpisodeDetailsViewController.swift
//  MovileProject
//
//  Created by iOS on 7/16/15.
//
//

import UIKit
import TraktModels
import Kingfisher

class EpisodeDetailsViewController: UIViewController {

    private var httpClient = TraktHTTPClient()
    var showSlug: String?
    var episode: Int?
    var season: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEpisode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var imageEpisode: UIImageView!
    
    @IBOutlet weak var titleEpisode: UILabel!
    
    @IBOutlet weak var textEpisode: UITextView!
    
    @IBOutlet var episodeView: UIView!
    
    deinit{
        println("\(self.dynamicType) deinit")
    }
    
    func loadEpisode(){
        if let showId = showSlug,
            seasonNumber = season,
            episodeNumber = episode{
                httpClient.getEpisode(showId, season: seasonNumber, episodeNumber: episodeNumber){[weak self] result in
                    if let episode = result.value{
                        self?.titleEpisode.text = episode.title
                        self?.textEpisode.text = episode.overview
                        
                        /*Setting image*/
                        let placeholder = UIImage(named: "poster")
                        if let url = episode.screenshot?.fullImageURL ?? episode.screenshot?.mediumImageURL ?? episode.screenshot?.thumbImageURL {
                            self?.imageEpisode.kf_setImageWithURL(url, placeholderImage: placeholder)
                        } else {
                            self?.imageEpisode.image = placeholder
                        }
                    }else{
                        println("An error occured \(result.error)")
                    }
                }
        }
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
