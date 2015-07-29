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
    private var favorites: [Show]?
    private var fm = FavoritesManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var showTabs: UISegmentedControl!
    
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
    
    func updateFavorite(){
        favorites = shows?.filter(serieIsFavorite)
        self.collectionView.reloadData()
    }
    
    func serieIsFavorite(serie: Show) -> Bool {
        for id in fm.favoritesIdentifiers {
                if id == serie.identifiers.trakt{
                    return true
                }
            }
        return false
    }
    
    var selectedShows: [Show]? {
        if showTabs.selectedSegmentIndex == 0 {
            return shows
        }else if showTabs.selectedSegmentIndex == 1{
            return favorites
        }
        return nil
    }
    
    func listenNotification(){
        let name = fm.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserver(self, selector: "updateFavorite", name: name, object: nil)
    }
    
    deinit{
        let name = fm.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: name, object: nil)
        println("\(self.dynamicType) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadShows()
        updateFavorite()
        listenNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue == Segue.SeasonsSegue {
            if let cell = sender as? UICollectionViewCell,
            indexPath = collectionView.indexPathForCell(cell) {
                let vc = segue.destinationViewController as! SeasonsViewController
                if let list = selectedShows{
                    vc.showSlug = list[indexPath.row].identifiers.slug
                    vc.serieTitle = list[indexPath.row].title
                    vc.traktId = list[indexPath.row].identifiers.trakt
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let list = selectedShows {
            return list.count
        }
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! SeriesCollectionViewCell
        if let list = selectedShows{
            cell.loadSerieFromInternet(list[indexPath.row])
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
    
    @IBAction func tabsChanged(sender: UISegmentedControl) {
        updateFavorite()
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
