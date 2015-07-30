//
//  EpisodesListViewController.swift
//  MovileProject
//
//  Created by iOS on 7/16/15.
//
//

import UIKit
import TraktModels
import Kingfisher

class EpisodesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listView: UITableView!
    
    private var httpClient = TraktHTTPClient()
    private var episodes: [Episode]?
    
    @IBOutlet weak var seasonImage: UIImageView!
    
    @IBOutlet weak var seasonTitle: UILabel!
    
    var season: Season?
    
    var showSlug: String?
    
    func loadEpisodes(){
        if let showId = showSlug,
            let seasonObj = season{
            httpClient.getEpisodes(showId, season: seasonObj.number){ [weak self] result in
                if let seasons = result.value{
                    self?.episodes = seasons
                    self?.listView.reloadData()
                }else{
                    println("An error occured \(result.error)")
                }
            }
        }
    }
    
    func loadSeasonHeader(){
        let placeholder = UIImage(named: "poster")
        if let seasonObj = season{
            if let url = seasonObj.poster?.fullImageURL ?? seasonObj.poster?.mediumImageURL ?? seasonObj.poster?.thumbImageURL {
                seasonImage.kf_setImageWithURL(url, placeholderImage: placeholder)
                seasonTitle.text = "Season \(seasonObj.number)"
            } else {
                seasonImage.image = placeholder
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
        loadEpisodes()
        loadSeasonHeader()
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.EpisodeSegue {
            if let cell = sender as? UITableViewCell,
            indexPath = listView.indexPathForCell(cell) {
                let vc = segue.destinationViewController as! EpisodeDetailsViewController
                if let list = episodes,
                    let seasonObj = season{
                        vc.showSlug = showSlug
                        vc.season = seasonObj.number
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

