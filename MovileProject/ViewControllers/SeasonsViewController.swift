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
    
     override func viewDidLoad() {
        super.viewDidLoad()
        loadSeasons()
        if isFavorite() {
            favoriteButton.tintColor = UIColor.redColor()
        }
        showTitle.title = serieTitle
        let fm = FavoritesManager()
        for id in fm.favoritesIdentifiers {
            println("id \(id)")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if let list = seasons{
            return list.count
        }
        return 2
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
        if let id = traktId {
            let fm = FavoritesManager()
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
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}