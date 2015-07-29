//
//  EpisodesListViewController.swift
//  MovileProject
//
//  Created by iOS on 7/16/15.
//
//

import UIKit
import TraktModels

class EpisodesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listView: UITableView!
    
    private var httpClient = TraktHTTPClient()
    private var episodes: [Episode]?
    var showSlug: String?
    var season: Int?
    
    func loadSeasons(){
        if let showId = showSlug,
            let seasonNumber = season{
            httpClient.getEpisodes(showId, season: seasonNumber){ [weak self] result in
                if let seasons = result.value{
                    self?.episodes = seasons
                    self?.listView.reloadData()
                }else{
                    println("An error occured \(result.error)")
                }
            }
        }
    }
    
    deinit{
        println("\(self.dynamicType) deinit")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let index = listView.indexPathForSelectedRow(){
            listView.deselectRowAtIndexPath(index, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSeasons()
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.EpisodeSegue {
            if let cell = sender as? UITableViewCell,
            indexPath = listView.indexPathForCell(cell) {
                let vc = segue.destinationViewController as! EpisodeDetailsViewController
                if let list = episodes{
                    vc.showSlug = showSlug
                    vc.season = season
                    vc.episode = list[indexPath.row].number
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = episodes{
            return list.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = Reusable.Cell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! CellTableViewCell
        if let list = episodes{
            cell.loadSeason(list[indexPath.row])
        }
        return cell
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

