//
//  CellTableViewCell.swift
//  MovileProject
//
//  Created by iOS on 7/16/15.
//
//

import UIKit
import TraktModels

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeTitle: UILabel!
    
    @IBOutlet weak var episodeInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadSeason(episode: Episode){
        if let title = episode.title{
            episodeInfo.text = "S0\(episode.seasonNumber)E0\(episode.number)"
            episodeTitle.text = "\(title)"
        }
    }
    
    override func prepareForReuse() {
        episodeTitle.text = ""
    }

    
}
