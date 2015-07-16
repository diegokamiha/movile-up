//
//  Episode.swift
//  MovileProject
//
//  Created by iOS on 7/16/15.
//
//

import Foundation

struct Episode {
    let title : String
    let number: Int
    
    static func allEpisodes() -> [Episode] {
       let episodes = [("Episode 1", 1), ("Episode 2", 2), ("Episode 3", 3)]
        
        return episodes.map{Episode(title: $0.0 number: $0.1))}
    }
}