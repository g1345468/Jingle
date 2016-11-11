//
//  ArtistAlbumViewController.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/09.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistAlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var albumTable: UITableView!
 
    var albumNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
   
        navigationItem.title = MusicInfo.selectedArtist
        
        let query = MPMediaQuery.albumsQuery()
       
        let predicate = MPMediaPropertyPredicate(value: MusicInfo.selectedArtist, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.EqualTo)
        query.addFilterPredicate(predicate)
        
        for collection in query.collections! {
            let albumName = collection.representativeItem!.albumTitle ?? "不明"
            albumNames.append(albumName)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistAlbumCell", forIndexPath: indexPath)
        cell.textLabel!.text = albumNames[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MusicInfo.selectedAlbum = albumNames[indexPath.row]
        albumTable.deselectRowAtIndexPath(indexPath, animated: true)
    }



}
