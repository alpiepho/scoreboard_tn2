import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoreboard_tn/screens/scores_page.dart';

void main() {
  //runApp(Scoreboard());

  // We need to call it manually,
  // because we going to call setPreferredOrientations()
  // before the runApp() call
  WidgetsFlutterBinding.ensureInitialized();

  // Hide status bar
  //SystemChrome.setEnabledSystemUIOverlays([]);

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(Scoreboard()));

}

class Scoreboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Scoreboard TN",
      //theme: ThemeData.dark().copyWith(
      //  primaryColor: Color(0xFF0A0E21),
      //  accentColor: Color(0xFFEB1555),
      //  scaffoldBackgroundColor: Color(0xFF0A0E21),
      //  backgroundColor: Color(0xFF0A0E21),
      //),
      home: ScoresPage(),
    );
  }
}
