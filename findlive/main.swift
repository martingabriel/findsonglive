//
//  main.swift
//  findlive
//
//  little utility to open browser with youtube search of currently playing song in iTunes
//
//  Created by Martin Gabriel on 03/08/2019.
//  Copyright © 2019 Martin Gabriel. All rights reserved.
//

import Foundation
import Cocoa
import ScriptingBridge

@objc protocol iTunesApplication {
    @objc optional func currentTrack()-> AnyObject
    @objc optional var properties: NSDictionary {get}
}

let iTunesApp: AnyObject = SBApplication(bundleIdentifier: "com.apple.iTunes")!
let trackDict = iTunesApp.currentTrack!().properties as Dictionary
// if nil then no current track
if (trackDict["name"] != nil) {
    let songName = trackDict["name"] as! String
    let artist = trackDict["artist"] as! String
    
    var searchUrl = "https://www.youtube.com/results?search_query="
    searchUrl.append(artist.replacingOccurrences(of: " ", with: "+"))
    searchUrl.append("+")
    searchUrl.append(songName.replacingOccurrences(of: " ", with: "+"))
    searchUrl.append("+live")
    
    if let url = URL(string: searchUrl) {
        // open youtube search in default browser
        if NSWorkspace.shared.open(url) {
            print("Youtube search with song " + songName + " was opened.")
            
        }
    }
}
