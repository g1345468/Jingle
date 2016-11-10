//
//  FirstViewController.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/07.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import UIKit
import MediaPlayer

class MainViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    
    var player = MPMusicPlayerController()
    var mediaItem: MPMediaItem!
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet var rateLabels: [UILabel]!
    
    @IBOutlet weak var countLabel: UILabel!
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player = MusicInfo.player
        
        // 再生中のItemが変わった時に通知を受け取る
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(MainViewController.nowPlayingItemChanged(_:)), name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: player)
        notificationCenter.addObserver(self, selector: #selector(MainViewController.nowPlayingItemChanged(_:)), name: MPMusicPlayerControllerPlaybackStateDidChangeNotification, object: player)
        notificationCenter.addObserver(self, selector: #selector(MainViewController.willEnterForegroundNotification(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
        // 通知の有効化
        player.beginGeneratingPlaybackNotifications()
        
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.viewSwipe(_:)))
        swipe.numberOfTouchesRequired = 1  // 指の数
        swipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipe)

       
    }
    
    func viewSwipe(sender: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mediaItem = player.nowPlayingItem
        setPlayButton()
        if mediaItem != nil {
            updateSongInformationUI()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func willEnterForegroundNotification(notification: NSNotification) {
        setProperty()
    }
    
    func setProperty() {
        mediaItem = player.nowPlayingItem
        setPlayButton()
        if mediaItem != nil {
            updateSongInformationUI()
        }
    }

    func setPlayButton() {
        if player.playbackState == MPMusicPlaybackState.Paused {
            playButton.setTitle("▶︎", forState: UIControlState.Normal)
        } else if player.playbackState == MPMusicPlaybackState.Playing {
            playButton.setTitle("■", forState: UIControlState.Normal)
        }
        
    }
   
    
    func updateSongInformationUI() {
        
        // 曲情報表示
        // (a ?? b は、a != nil ? a! : b を示す演算子です)
        // (aがnilの場合にはbとなります)
        if(mediaItem != nil) {
            artistLabel.text = mediaItem.artist ?? "不明なアーティスト"
            songLabel.text = mediaItem.title ?? "不明な曲"
            setRateButton(mediaItem.rating)
            countLabel.text = String(mediaItem.playCount)
            if let artwork = mediaItem.artwork {
                let image = artwork.imageWithSize(imageView.bounds.size)
                imageView.image = image
            } else {
                // アートワークがないとき
                // (今回は灰色表示としました)
                imageView.image = nil
                imageView.backgroundColor = UIColor.grayColor()
            }
        }
        
        /*
        if mediaItem.artist?.characters.count <= 6 {
            artistLabel2.loadHTMLString("<center>" + mediaItem.artist! + "</center>", baseURL: nil)
        } else {
            artistLabel2.loadHTMLString("<marquee scrolldelay=40 truespeed scrollamount=1>" + mediaItem.artist! + "</marquee>", baseURL: nil)
        }
        */
        
       
        
    }
    
    func nowPlayingItemChanged(notification: NSNotification) {
        setProperty()
    }
    
    func setRateButton(rate: Int) {
        for (var i = 0; i < rateLabels.count; i++) {
            if(i < rate) {
                rateLabels[i].text = "★"
            } else {
                rateLabels[i].text = "・"
            }
        }
    }
    

       
    
    /*
    deinit {
        // 再生中アイテム変更に対する監視をはずす
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: player)
        // ミュージックプレーヤー通知の無効化
        player.endGeneratingPlaybackNotifications()
    }
 */


    @IBAction func pushPlayPause(sender: AnyObject) {
        if player.playbackState == MPMusicPlaybackState.Playing {
            player.pause()
            playButton.setTitle("▶︎", forState: UIControlState.Normal)
        } else {
            player.play()
            playButton.setTitle("■", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func pushPrevious(sender: AnyObject) {
        if player.currentPlaybackTime < 3.0 {
            player.skipToPreviousItem()
        } else {
            player.skipToBeginning()
        }
    }
    
    
    @IBAction func pushNext(sender: AnyObject) {
        player.skipToNextItem()
    }


}

