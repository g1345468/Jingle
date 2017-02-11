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
        return albumNames.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistAlbumCell", forIndexPath: indexPath)
        if(indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel!.textAlignment = NSTextAlignment.Center
            cell.textLabel!.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
            cell.textLabel!.text = String(albumNames.count) + "枚のアルバム"
        } else {
            cell.textLabel!.textAlignment = NSTextAlignment.Left
            cell.textLabel!.font = UIFont.systemFontOfSize(UIFont.labelFontSize())
            cell.textLabel!.text = albumNames[indexPath.row - 1]
        }
        return cell

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row != 0) {
            MusicInfo.selectedAlbum = albumNames[indexPath.row - 1]
            albumTable.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if(indexPath.row == 0) {
            return nil
        } else {
            return indexPath
        }
    }



    @IBAction func shuffle(sender: AnyObject) {
        let query = MPMediaQuery.artistsQuery()
        let predicate = MPMediaPropertyPredicate(value: MusicInfo.selectedArtist, forProperty: MPMediaItemPropertyArtist, comparisonType: MPMediaPredicateComparison.EqualTo)
        query.addFilterPredicate(predicate)
        MusicInfo.player.setQueueWithQuery(query)
        MusicInfo.player.shuffleMode = MPMusicShuffleMode.Songs
        MusicInfo.player.play()
    }

}
