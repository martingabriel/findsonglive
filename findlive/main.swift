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

let optionLive = "+live"
let optionAccoustic = "+accoustic"
let optionCover = "+cover"

let iTunesApp: AnyObject = SBApplication(bundleIdentifier: "com.apple.iTunes")!
let trackDict = iTunesApp.currentTrack!().properties as Dictionary
// if nil then no current track
if (trackDict["name"] != nil) {
    let songName = trackDict["name"] as! String
    let artist = trackDict["artist"] as! String
    var searchOption = optionLive
    
    for argument in CommandLine.arguments {
        switch argument {
        case "-a":
            searchOption = optionAccoustic
            print("[-a] search acoustic")
        case "-c":
            searchOption = optionCover
            print("[-c] search cover")
        case "-l":
            searchOption = optionLive
            print("[-l] search live")
        default:
            searchOption = optionLive
            print("default live")
        }
    }
    
    var searchUrl = "https://www.youtube.com/results?search_query="
    searchUrl.append(artist.replacingOccurrences(of: " ", with: "+"))
    searchUrl.append("+")
    searchUrl.append(songName.replacingOccurrences(of: " ", with: "+"))
    searchUrl.append(searchOption)
    
    if let url = URL(string: searchUrl) {
        // open youtube search in default browser
        if NSWorkspace.shared.open(url) {
            print("Youtube search with song " + songName + " was opened.")
            
        }
    }
}
