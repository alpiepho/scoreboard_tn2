## Get Application
Version: 2.0

GH-Pages site: https://alpiepho.github.io/scoreboard_tn2/

or QR Code:

![QR Code](./qr-code.png)

## "Install" on iPhone

This application is a Web application known as a PWA (progressive web application).  It is possible to add a PWA to the home screen of an iPhone
like it is a downloaded application (there is a similare mechanism for Android that is not discused here).  Use the following steps:

1. Open the above link in Safari and click on up-arrow

![Step1](./iphone_install1.png)

2. Click on "Add to Home Screen"

![Step2](./iphone_install2.png)

3. Select "Add"

![Step3](./iphone_install3.png)


### Known Issue

A PWA on iPhone requires internet access to launch the first time.  However, once it is running, the application will work fine without and an internet connection.

## About
My flutter version of a Scoreboard application.

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

## Todo and Future Changes
- build ios
- ios developer install
- ios store?

- debug painting
- faster draw after rotate?
- fix rotate
- refactor settings modal (from bottom?)
- track sets
- better contrast?
- ways to share score better?
- mic to annotate?
- remote BT device?

- refactor long files
- More fonts
- Fix more Lighthouse issues (might be in Flutter)

## Reference

Icons created with https://appicon.co/  NOTE: original image should be square to avoid white edges on IOS Home screen.

QR code generated with https://www.the-qrcode-generator.com/.  Used screen capture to save qrocode.png and copied file here.