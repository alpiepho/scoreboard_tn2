# scoreboard_tn

My flutter version of a Scoreboard application.

GH-Pages site: https://alpiepho.github.io/scoreboard_tn/

This application was built to better learn Flutter and Dart.  The world really doesn't need another simple scoring application, but attempting to duplicate how several of these common applications work, provided a way to learn many things:

- Flutter itself
- Flutter web applications as a PWA
- Learn about some of it's short commings with respect to a Google Lighthouse score
- Arranging cards
- Gesture detection and processing
- Modal dialogs
- Color Pickers
- Google fonts within Flutter
- Persistent Data
- Several other areas

These are all areas that I hope to take forward into other applications.  Flutter is fun.

## Basic Usages

The application from the above URL will open a respoonsive web page.  It is best viewed on a mobile phone with the most testing on and iPhoneX.  If opened on iPhone Safari, you can used the middle bottom button to add to the Home Screen (as a PWA).

The application opens with two large colored buttons for two teams.  Tapping either will icrement their score.  Swiping up will increment the score.  Swiping down will decrement with a limit at 0.  The Gear button will open a settings dialog.

The settings dialog allows some quick actions from icons at the top: clear scores, swap teams, and a done checkmark to save settings listed below.  All saved settings are added to the persistent storage so the next launch will read them and the user can pick up where they left off.

Other settings allow changing the team names, adjusting scores, and picking colors for the team text and background.

At the bottom are a number of predefined fonts.  These are like the top icons, and will immediately be saved.

Below are some lists of things yet to do and possible future changes.

Thanks for trying out this applications.

## Recording Timestamps

A simple recorder with timestamps was added.  One use might be to add indexing to a YouTube video.  To use this, go to the settings page and scroll to the bottom.  Select Start to clear and start a new session.  Click stop to stop.

As the score is updated, a line with the score details is added.  Finally, use the Copy Clipboard to get a copy of the session.

The following is an example of what would be copied to the clipboard:
```
00:00 Start
01:33 Away 1, Home 0
...
```

NOTE: at this time there is no indication that recording is enabled.


## Todo and Future Changes


- time rate selector for recording
    - settings rate
    - use rate to scale time

- add earned score
    - add setting checkmark for earned scoring
    - detect upper right select
    - add button labels for earned button, earned score
    - add earned score below score
    ```
    00:00 Start
    01:33 actual: Away 10, Home 9     earned: Away 1, Home 2
    ...
    ```


- add screen to show recording results

- add setting for youtube link
- add screen to show youtube links
- launch youtube link
- copy youtube link to clipboard


- fix settings landscape keyboard
- More fonts
- Move fonts to another dialog?
- Move timestamps to another dialog?
- Idea: Tie into time markers for associated YouTube/Other video
- Fix more Lighthouse issues (might be in Flutter)
- Fix top bar (but it does show time etc)
- Fix no-rotation (setup but still rotates)

## Reference

Icons created with https://appicon.co/  NOTE: original image should be square to avoid white edges on IOS Home screen.

## (Original Flutter Starter README) Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
