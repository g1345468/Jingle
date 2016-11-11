//
//  PlayingMedia.swift
//  Jingle
//
//  Created by Yamada Seisuke on 2016/11/09.
//  Copyright © 2016年 Ito.inc. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicInfo {
    static let player = MPMusicPlayerController.systemMusicPlayer()
    
    static var selectedArtist: String?
    static var selectedAlbum: String?
}
