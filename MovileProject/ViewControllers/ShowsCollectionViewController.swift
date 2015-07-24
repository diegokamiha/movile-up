//
//  ShowsCollectionViewController.swift
//  MovileProject
//
//  Created by iOS on 7/17/15.
//
//

import UIKit
import TraktModels
import Result

class ShowsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    private var httpClient = TraktHTTPClient()
    private var shows: [Show]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func loadShows(){
        httpClient.getPopularShows{ [weak self] result in
            if let shows = result.value{
                self?.shows = shows
                self?.collectionView.reloadData()
            }else{
                println("An error occured \(result.error)")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadShows()
        /*httpClient.getShow("game-of-thrones", completion: printShow)
        httpClient.getEpisode("game-of-thrones", season: 1, episodeNumber: 1, completion: printEpisode)
        httpClient.getPopularShows(printPopularShows)
        httpClient.getSeasons("game-of-thrones", completion: printSeasons)
        httpClient.getEpisodes("game-of-thrones", season: 1, completion: printEpisodes)*/
        // Do any additional setup after loading the view.
    }
    
    /*===================================================   BEGIN - TESTS ==============================================================================================*/
    
    func printShow(show: Result<Show, NSError?>) -> Void{
        if let rShow = show.value{
            println(rShow.title)
        }else{
            println("An error occured")
        }
    }
    
    func printEpisode(episode: Result<Episode, NSError?>) -> Void{
        if let rEpisode = episode.value{
            println(rEpisode.title)
        }else{
            println("An error occured")
        }
    }
    
    func printPopularShows(popularShows: Result<[Show], NSError?>) -> Void{
        if let array =  popularShows.value{
            for elem in array {
                println(elem.title)
            }
        }else{
            println("An error occured")
        }
    }
    
    func printSeasons(seasons: Result<[Season], NSError?>) -> Void{
        if let array = seasons.value{
            for elem in array {
                println(elem.number)
            }
        }else{
            println("An error occured")
        }
    }
    
    func printEpisodes(episodes: Result<[Episode], NSError?>) -> Void {
        if let array = episodes.value{
            for elem in array{
                println(elem.title)
            }
        }else{
            println("An error occured")
        }
    }
    
    /*=================================================== END - TESTS ==================================================================================================*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.SeasonsSegue {
            if let cell = sender as? UICollectionViewCell,
            indexPath = collectionView.indexPathForCell(cell) {
                let vc = segue.destinationViewController as! EpisodesListViewController
                if let list = shows{
                    vc.showSlug = list[indexPath.row].identifiers.slug
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = shows {
            return list.count
        }
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! SeriesCollectionViewCell
        if let list = shows{
            cell.loadSerieFromInternet(list[indexPath.row])
            //cell.loadSeries(series[indexPath.row])
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: space, bottom: flowLayout.sectionInset.bottom, right: space)
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
