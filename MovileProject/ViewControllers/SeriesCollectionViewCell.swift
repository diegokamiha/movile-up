    //
//  SeriesCollectionViewCell.swift
//  MovileProject
//
//  Created by iOS on 7/17/15.
//
//

import UIKit
import TraktModels
import Kingfisher
    
class SeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serieImage: UIImageView!
    
    @IBOutlet weak var serieTitle: UILabel!
    
    private var task: RetrieveImageTask?
    
    func loadSerieFromInternet (show: Show){
        let placeholder = UIImage(named: "poster")
        if let url = show.poster?.fullImageURL ?? show.poster?.mediumImageURL ?? show.poster?.thumbImageURL {
            serieImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            serieImage.image = placeholder
        }
        serieTitle.text = show.title
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            task?.cancel()
            task = nil
            serieImage.image = nil
    }
}
