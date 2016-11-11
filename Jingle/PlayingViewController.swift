//
//  PlayingViewController.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/10.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayingViewController: UIViewController {
    
    @IBOutlet weak var playingView: UIView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayingViewController.nowPlayingItemChanged(_:)), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: MusicInfo.player)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayingViewController.nowPlayingItemChanged(_:)), name: MPMusicPlayerControllerPlaybackStateDidChangeNotification, object: MusicInfo.player)
        
        // 通知の有効化
        MusicInfo.player.beginGeneratingPlaybackNotifications()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PlayingViewController.viewTap(_:)))
        playingView.addGestureRecognizer(tap)
     
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
    
    func updatePlayingView() {
        let playingItem = MusicInfo.player.nowPlayingItem
        if(playingItem != nil) {
            songLabel.text = playingItem!.title ?? "不明な曲"
            artistLabel.text = playingItem!.artist ?? "不明なアーティスト"
        }
    }
    
    func viewTap(sender: UITapGestureRecognizer) {
        
        playingView.backgroundColor = UIColor.grayColor()
        let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("playing")
        self.presentViewController(nextView!, animated: true, completion: nil)
        
    }

}
