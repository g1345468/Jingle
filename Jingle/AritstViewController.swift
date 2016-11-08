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
    @IBOutlet weak var artistTable: UITableView!
    
    var artistNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtistViewController.viewTap(_:)))
        playingView.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ArtistViewController.viewSwipe(_:)))
        playingView.addGestureRecognizer(swipe)
        
        self.view.bringSubviewToFront(playingView)

        let query = MPMediaQuery.artistsQuery()
        for collection in query.collections! {
            let artistName = collection.representativeItem!.artist ?? "不明"
            artistNames.append(artistName)
        }

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewTap(sender: UITapGestureRecognizer) {
        
        let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("playing")
        self.presentViewController(nextView!, animated: true, completion: nil)
 
    }
    
    func viewSwipe(sender: UISwipeGestureRecognizer) {
        let nextView = self.storyboard?.instantiateViewControllerWithIdentifier("artist")
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
    
    
    
    
    /*
    func showPlaying(gestureRecognizer: UITapGestureRecognizer) {
        self.presentedViewController(FirstViewController, animated: true, completion: nil)
    }
 */

    
}

