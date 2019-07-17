# Lemmings in your touch bar
![screenshot](https://github.com/erikolsson/Touch-Bar-Lemmings/blob/master/media/screenshot.jpg?raw=true)

Proof of concept.. but why not!

# Build & run

```
xcodebuild clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
# If the build fails on TouchLemmings/LemmingsScene.swift
# Update this file and change the minimal version of Mac OS X
open build/Release/TouchLemmings.app

```

# Spawn lemmings

Just hit the touch bar while the application is in the foreground. Tapping a walking lemming will transform it into a blocker. Tapping a floating lemming will cause it to land and start walking. Long press to clear the screen and start over.
