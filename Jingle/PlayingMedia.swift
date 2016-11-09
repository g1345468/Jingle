//
//  PlayingMedia.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/09.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import Foundation
import MediaPlayer

class PlayingMedia {
    static let player = MPMusicPlayerController.systemMusicPlayer()
    static let playingMedia = PlayingMedia()
    var artist: String?
    var song: String?
}
