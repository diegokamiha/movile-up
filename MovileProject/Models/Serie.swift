//
//  Serie.swift
//  MovileProject
//
//  Created by iOS on 7/17/15.
//
//

import Foundation

struct Serie {
    let title: String
    let imageName: String
    
    static func allSeries() -> [Serie]{
        let series = [("Pokemon 1", "clock"), ("Pokemon 2", "favs"), ("Pokemon 3", "poster-mini")]
        return series.map { Serie(title: $0.0, imageName: $0.1) }
    }
}