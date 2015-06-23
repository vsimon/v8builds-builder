# v8builds-builder
=======
How [v8builds](https://github.com/vsimon/v8builds) gets built. The goal of [v8builds](https://github.com/vsimon/v8builds) is to provide a single standalone v8 static library and package.

## Current Platforms and Prerequisites
* OSX (highly recommend [Homebrew](http://brew.sh/) is installed)
* Linux (tested on Ubuntu 12.04/14.04 64-bit)

## How to run
`./build.sh` to build the latest version of v8.

Or optionally another version specified by git SHA:

```
./build.sh options

OPTIONS:
   -h   Show this message
   -r   Revision represented as a git tag version i.e. 4.5.73 (optional, builds latest version if omitted)
```

## Where is the package
`out/v8builds-<ver>-<plat>.zip`
where `<ver>` is the tagged version of v8, and `<plat>` is the platform (linux64, windows, osx).
