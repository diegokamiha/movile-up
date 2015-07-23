    //
//  SeriesCollectionViewCell.swift
//  MovileProject
//
//  Created by iOS on 7/17/15.
//
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var serieImage: UIImageView!
    
    @IBOutlet weak var serieTitle: UILabel!
    
    func loadSerieFromInternet (title: String, image: String){
        let url = NSURL(string: image)
        let data = NSData(contentsOfURL: url!)
        serieImage.image = UIImage(data: data!)
        
        serieTitle.text = title
    }
}
