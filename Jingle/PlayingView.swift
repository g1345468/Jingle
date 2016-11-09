//
//  AllController.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/08.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer



class PlayingView: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtistViewController.viewTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ArtistViewController.viewTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    
    
    
    
}
