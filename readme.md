# findsonglive

Little tool for youtube search of live or acoustic version of song that you currently listening in iTunes. Tested on macOS 10.14 with SWIFT5.

## Easy to use

Run findlive from terminal and it will open your default browser page with youtube search of currently playing song. You can use arguments to specify search type:
- [-l] live
- [-a] acoustic
- [-c] cover
- [-p] piano

You can combine these arguments. Script call can look like these:

```sh
# find live version of song
./findlive
./findlive -l

# find acoustic live version of song
./findlive -a -l

# find acoustic piano cover version of song
./findlive -a -p -c
```



## Example

![example](example.gif)

