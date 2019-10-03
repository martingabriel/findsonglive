# 🎧 findsonglive

Little tool for youtube search of live or another versions of song that you are currently listening in **iTunes** or **Spotify** macOS apps. Tested on macOS 10.14 with SWIFT5.

If you love music you know artists that makes incredible live performance of their songs. Lot of these masterpieces are available on YouTube, but not on iTunes or Spotify. Maybe piano, acoustic or cover version fits better to your ears and taste. This tool can help you to find them and enjoy them. ♥️

## Easy to use

Run findlive from terminal and it will open your default web browsers new tab with youtube search of currently playing song in your music player (iTunes or Spotify are now supported). You can use arguments to specify search type:
- [-l] live
- [-a] acoustic
- [-c] cover
- [-p] piano

You can combine all these arguments. Here are some examples of arguments usage:

```sh
# find live version of currently playing song
./findlive
./findlive -l

# find acoustic live version of currently playing song
./findlive -a -l

# find acoustic piano cover version of currently playing song
./findlive -a -p -c
```

## Example

![example](example.gif)

## References

Spotify bridge inspired by [@gf3](https://github.com/gf3)