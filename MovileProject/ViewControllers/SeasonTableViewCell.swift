//
//  SeasonTableViewCell.swift
//  MovileProject
//
//  Created by iOS on 7/27/15.
//
//

import UIKit
import TraktModels
import Kingfisher
import FloatRatingView

class SeasonTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var numberOfEpisodes: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var seasonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadSeason(season: Season){
        /*Setting image*/
        let placeholder = UIImage(named: "poster")
        if let url = season.poster?.fullImageURL ?? season.poster?.mediumImageURL ?? season.poster?.thumbImageURL {
            seasonImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            seasonImage.image = placeholder
        }

        title.text = "Season \(season.number)"
        numberOfEpisodes.text = "\(season.episodeCount!) episodes"
        ratingView.rating = season.rating!
    }
}
