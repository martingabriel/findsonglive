# findsonglive

Little tool for youtube search of live or acoustic version of song that you currently listening in **iTunes** or **Spotify** macOS apps. Tested on macOS 10.14 with SWIFT5.

## Easy to use

Run findlive from terminal and it will open your default browser new tab page with youtube search of currently playing song. You can use arguments to specify search type:
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