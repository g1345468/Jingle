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
    

    @IBOutlet weak var artistTable: UITableView!
    @IBOutlet weak var playingView: UIView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    var artistNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ArtistViewController.nowPlayingItemChanged(_:)), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: MusicInfo.player)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtistViewController.viewTap(_:)))
        playingView.addGestureRecognizer(tap)
    
        
        let query = MPMediaQuery.artistsQuery()
        for collection in query.collections! {
            let artistName = collection.representativeItem!.artist ?? "不明"
            artistNames.append(artistName)
        }
    }
    
    func updatePlayingView() {
        let playingItem = MusicInfo.player.nowPlayingItem
        if(playingItem != nil) {
            songLabel.text = playingItem!.title ?? "不明な曲"
            artistLabel.text = playingItem!.artist ?? "不明なアーティスト"
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistNames.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistCell", forIndexPath: indexPath)
        if(indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textLabel!.textAlignment = NSTextAlignment.Center
            cell.textLabel!.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
            cell.textLabel!.text = String(artistNames.count) + "人のアーティスト"
        } else {
            cell.textLabel!.textAlignment = NSTextAlignment.Left
            cell.textLabel!.font = UIFont.systemFontOfSize(UIFont.labelFontSize())
            cell.textLabel!.text = artistNames[indexPath.row - 1]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row != 0) {
            MusicInfo.selectedArtist = artistNames[indexPath.row - 1]
        
            let back = UIBarButtonItem()
            back.title = "戻る"
            navigationItem.backBarButtonItem = back
        
            artistTable.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if(indexPath.row == 0) {
            return nil
        } else {
            return indexPath
        }
    }

    
}

