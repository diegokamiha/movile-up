//
//  SeasonsViewController.swift
//  MovileProject
//
//  Created by iOS on 7/27/15.
//
//

import UIKit
import TraktModels

class SeasonsViewController: UITableViewController {

    @IBOutlet var listView: UITableView!

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var showSlug: String?
    var serieTitle: String?
    var traktId: Int?
    
    private var seasons: [Season]?
    private var httpClient = TraktHTTPClient()
    
    @IBOutlet weak var showTitle: UINavigationItem!
    
    func loadSeasons(){
        if let showId = showSlug {
            httpClient.getSeasons(showId){ [weak self] result in
                if let seasons = result.value {
                    self?.seasons = seasons
                    self?.listView.reloadData()
                }else{
                    println("An error occured:/\(result.error) ")
                }
            }
        }
    }
    func isFavorite() -> Bool{
        var fm = FavoritesManager()
        for id in fm.favoritesIdentifiers {
            if id == traktId {
                return true
            }
        }
        return false
    }
    
    deinit{
        println("\(self.dynamicType) deinit")
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        loadSeasons()
        if isFavorite() {
            favoriteButton.tintColor = UIColor.redColor()
        }
        showTitle.title = serieTitle
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.EpisodesSegue {
            if let cell = sender as? UITableViewCell,
                indexPath = listView.indexPathForCell(cell) {
                    let vc = segue.destinationViewController as! EpisodesListViewController
                    if let list = seasons{
                        vc.showSlug = showSlug
                        vc.season = list[indexPath.row].number
                    }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = seasons{
            return list.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var identifier = Reusable.seasonCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SeasonTableViewCell
        if let list = seasons {
            cell.loadSeason(list[indexPath.row])
        }
        return cell
    }
    
    @IBAction func favorite(sender: UIBarButtonItem) {
        let fm = FavoritesManager()
        if let id = traktId {
            if !isFavorite(){
                fm.addIdentifier(id)
                favoriteButton.tintColor = UIColor.redColor()
            }else{
                fm.removeIdentifier(id)
                favoriteButton.tintColor = UIColor.whiteColor()
            }
        }else {
            println("An error occured")
        }
        let name = fm.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(name, object: self)
    }

}