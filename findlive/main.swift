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

// search constants
let optionLive = "+live"
let optionAccoustic = "+accoustic"
let optionCover = "+cover"
let optionPiano = "+piano"
let searchQuery = "https://www.youtube.com/results?search_query="

// track info
let iTunesApp: AnyObject = SBApplication(bundleIdentifier: "com.apple.iTunes")!
let trackDict = iTunesApp.currentTrack!().properties as Dictionary

if let songName = trackDict["name"], let artist = trackDict["artist"] {
    var searchOptions = [String]()
    
    // get CLI arguments (search options)
    for argument in CommandLine.arguments {
        if CommandLine.arguments.count > 1 {
            switch argument {
                case "-a":
                    searchOptions.append(optionAccoustic)
                    print("[-a] search acoustic")
                case "-c":
                    searchOptions.append(optionCover)
                    print("[-c] search cover")
                case "-l":
                    searchOptions.append(optionLive)
                    print("[-l] search live")
                case "-p":
                    searchOptions.append(optionPiano)
                    print("[-p] search piano")
                default:
                    // undefined option
                    print("\(argument) is undefined parameter.")
            }
        } else {
            searchOptions.append(optionLive)
            print("[-l] default search live")
        }
    }
    
    // search url
    var searchUrl = searchQuery
    searchUrl.append((artist as AnyObject).replacingOccurrences(of: " ", with: "+"))
    searchUrl.append("+")
    searchUrl.append((songName as AnyObject).replacingOccurrences(of: " ", with: "+"))
    
    // add search options
    for searchOption in searchOptions {
        searchUrl.append(searchOption)
    }
    
    // open youtube search in default browser
    if let url = URL(string: searchUrl) {
        if NSWorkspace.shared.open(url) {
            print("Youtube search with song \(songName) was opened.")
            
        }
    }
} else {
    // no currenly playing track
    print("No currently playing track in iTunes.")
}
