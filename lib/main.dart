import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:scoreboard_tn2/screens/scores_page.dart';

void main() {
  //debugRepaintRainbowEnabled = true;
  runApp(Scoreboard());
}

class Scoreboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scoreboard TN2",
      home: ScoresPage(),
    );
  }
}
