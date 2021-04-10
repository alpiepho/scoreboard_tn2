import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard_tn/components/reusable_card.dart';
// import 'package:unit_calculator/components/bottom_button.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage(
      {required this.unitType});

  final int unitType;

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: kToolbarHeightPortrait,
        //   title: Text(kToolbarTitle),
        // ),
        body: Center(
          child: Container(
            width: kMainContainerWidthPortrait,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "A simple Flutter web application as PWA.",
                            style: kLabelTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Version: " + kVersion,
                            style: kLabelTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: new RichText(
                              text: new TextSpan(
                                children: [
                                  new TextSpan(
                                    text: "https://github.com/alpiepho/unit_calculator",
                                    style: new TextStyle(color: Colors.blue),
                                    recognizer:  new TapGestureRecognizer()
                                               ..onTap = () { launch('https://github.com/alpiepho/unit_calculator');
                                               },
                                  ),
                                ],
                              ),
                            ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Copyright 2021, Thatname Group.",
                            style: kLabelTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Settings Pending",
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    else {
      return Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: kToolbarHeightLandscape,
        //   title: Text(kToolbarTitle),
        // ),
        body: Center(
          child: Container(
            width: kMainContainerWidthLandscape,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "A simple Flutter web application as PWA.\n  Version: " + kVersion + " \n https://github.com/alpiepho/unit_calculator \n Copyright 2021, Thatname Group.",
                            style: kLabelTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Settings Pending",
                          style: kLabelTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
