//
//  SecondViewController.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/07.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var playingView: UIView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artistTable: UITableView!
    
    var artistNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ArtistViewController.nowPlayingItemChanged(_:)), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: PlayingMedia.player)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtistViewController.viewTap(_:)))
        playingView.addGestureRecognizer(tap)
    
        
        let query = MPMediaQuery.artistsQuery()
        for collection in query.collections! {
            let artistName = collection.representativeItem!.artist ?? "不明"
            artistNames.append(artistName)
        }
        
        setPlayingView()

    }
    
    func setPlayingView() {
        let playingItem: MPMediaItem! = PlayingMedia.player.nowPlayingItem
        if(playingItem != nil) {
            songLabel.text = playingItem.title ?? "不明な曲"
            artistLabel.text = playingItem.artist ?? "不明なアーティスト"
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        playingView.backgroundColor = Common.thinGray
    }
    
    func nowPlayingItemChanged(notification: NSNotification) {
        setPlayingView()
    }
    
    func viewTap(sender: UITapGestureRecognizer) {
        
        playingView.backgroundColor = UIColor.grayColor()
        let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("playing")
        self.presentViewController(nextView!, animated: true, completion: nil)
 
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistCell", forIndexPath: indexPath)
        cell.textLabel!.text = artistNames[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    
}

