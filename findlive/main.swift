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

// search constants
let optionLive = "+live"
let optionAccoustic = "+accoustic"
let optionCover = "+cover"
let optionPiano = "+piano"
let searchQuery = "https://www.youtube.com/results?search_query="

// iTunes & Spotify applications
let iTunesApp: AnyObject = SBApplication(bundleIdentifier: "com.apple.iTunes")!
let spotifyApp: AnyObject = SBApplication(bundleIdentifier: "com.spotify.client")!

var SongName : AnyObject?
var Artist : AnyObject?

if let iTunesRunning = iTunesApp.isRunning {
    print("iTunes app running: \(iTunesRunning)")
    
    if iTunesRunning {
        let trackDict = iTunesApp.currentTrack!().properties as Dictionary
        
        if let songname = trackDict["name"], let artist = trackDict["artist"] {
            SongName = songname as AnyObject
            Artist = artist as AnyObject
        }
    }
}

if let spotifyRunning = spotifyApp.isRunning {
    print("Spotify app running: \(spotifyRunning)")
    
    if spotifyRunning {
        SongName = spotifyApp.currentTrack!.name as AnyObject
        Artist = spotifyApp.currentTrack!.artist as AnyObject
    }
}

if let songName = SongName, let artist = Artist {
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
