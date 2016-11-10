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
    @IBOutlet weak var playingView: UIView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var albumNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ArtistAlbumViewController.nowPlayingItemChanged(_:)), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: MusicInfo.player)
        
        navigationItem.title = MusicInfo.selectedArtist
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtistAlbumViewController.viewTap(_:)))
        playingView.addGestureRecognizer(tap)

        
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
    
    override func viewWillAppear(animated: Bool) {
        playingView.backgroundColor = Common.thinGray
        updatePlayingView()
    }
    
    func nowPlayingItemChanged(notification: NSNotification) {
        updatePlayingView()
    }
    
    func viewTap(sender: UITapGestureRecognizer) {
        
        playingView.backgroundColor = UIColor.grayColor()
        let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("playing")
        self.presentViewController(nextView!, animated: true, completion: nil)
        
    }


    
    func updatePlayingView() {
        let playingItem = MusicInfo.player.nowPlayingItem
        if(playingItem != nil) {
            songLabel.text = playingItem!.title ?? "不明な曲"
            artistLabel.text = playingItem!.artist ?? "不明なアーティスト"
        }
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
