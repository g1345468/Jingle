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
    
    var artistNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = MPMediaQuery.artistsQuery()
        for collection in query.collections! {
            let artistName = collection.representativeItem!.artist ?? "不明"
            artistNames.append(artistName)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

