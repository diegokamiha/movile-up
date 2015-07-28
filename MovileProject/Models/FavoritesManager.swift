//
//  FavoritesManager.swift
//  MovileProject
//
//  Created by iOS on 7/28/15.
//
//

import Foundation

class FavoritesManager {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var favoritesIdentifiers: Set<Int>{
        get{
          /* if let favoritesIds = defaults.arrayForKey("favorites"){
                    for id in favoritesIds {
                        if let favoriteId = id as? Int{
                            favorites.insert(favoriteId)
                        }
                    }
            }
        return favorites
        }*/
            if let favoritesIds = defaults.arrayForKey("favorites") as? [Int]{
                return Set<Int>(favoritesIds)
            }
            return Set<Int>()
        }
    }
    
    func addIdentifier(identifier: Int) {
        var ids = self.favoritesIdentifiers
                ids.insert(identifier)
                let arrayIds = Array(ids)
                defaults.setValue(arrayIds, forKey: "favorites")
                defaults.synchronize()
    }
    
    func removeIdentifier(identifier: Int) {
        var ids = self.favoritesIdentifiers
            ids.remove(identifier)
            let arrayIds = Array(ids)
            defaults.setValue(arrayIds, forKey: "favorites")
            defaults.synchronize()
    }
}