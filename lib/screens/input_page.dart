import 'package:flutter/material.dart';
import 'package:scoreboard_tn/components/score_card.dart';
import 'package:scoreboard_tn/components/settings_button.dart';
import 'package:scoreboard_tn/components/settings_modal.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String _labelLeft = "Away";
  String _labelRight = "Home";
  int _valueLeft = 0;
  int _valueRight = 0;

  double _panPositionXLeft = 0.0;
  double _panPositionXRight = 0.0;

  double _panPositionYLeft = 0.0;
  double _panPositionYRight = 0.0;



  _readPersistentData() async {
    final prefs = await SharedPreferences.getInstance();
    final labelLeft = prefs.getString('labelLeft') ?? 'Away';
    final labelRight = prefs.getString('labelRight') ?? 'Home';
    final valueLeft = prefs.getInt('valueLeft') ?? 0;
    final valueRight = prefs.getInt('valueRight') ?? 0;
    setState(() {
      _labelLeft = labelLeft;
      _labelRight = labelRight;
      _valueLeft = valueLeft;
      _valueRight = valueRight;
    });
  }

  _savePersistentData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('labelLeft', _labelLeft);
    prefs.setString('labelRight', _labelRight);
    prefs.setInt('valueLeft', _valueLeft);
    prefs.setInt('valueRight', _valueRight);
  }

  void _incrementLeft() async {
    setState(() {
      _valueLeft += 1;
    });
  }

  void _decrementLeft() async {
    setState(() {
      _valueLeft -= 1;
      if (_valueLeft < 0) _valueLeft = 0;
    });
  }

  void _incrementRight() async {
    setState(() {
      _valueRight += 1;
    });
  }

  void _decrementRight() async {
    setState(() {
      _valueRight -= 1;
      if (_valueRight < 0) _valueRight = 0;
    });
  }

  void _clearBoth() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clear Scores'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you clear scores?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Clear'),
              onPressed: () {
                setState(() {
                  _valueLeft = 0;
                  _valueRight = 0;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _resetBoth() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reset All'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you reset everything?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Reset'),
              onPressed: () {
                setState(() {
                  _labelLeft = "Away";
                  _labelRight = "Home";
                  _valueLeft = 0;
                  _valueRight = 0;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _swapTeams() async {
    setState(() {
      var valueTemp = _valueLeft;
      _valueLeft = _valueRight;
      _valueRight = valueTemp;
      var labelTemp = _labelLeft;
      _labelLeft = _labelRight;
      _labelRight = labelTemp;
    });
    Navigator.of(context).pop();
  }

  void _saveBoth() async {
    // setState(() {
    //   _labelLeft = "Away";
    //   _labelRight = "Home";
    //   _valueLeft = 0;
    //   _valueRight = 0;
    // });
    Navigator.of(context).pop();
  }

  void _panUpdateLeft(DragUpdateDetails details) async {
    // use swipe to adjust score
    if (details.delta.dy.abs() > 1) {
      _panPositionYLeft += details.delta.dy;
      if (_panPositionYLeft < -100) {
        _panPositionYLeft = 0.0;
        _incrementLeft();
      } else if (_panPositionYLeft > 100) {
        _panPositionYLeft = 0.0;
        _decrementLeft();
      }
    } else {
      _panPositionYLeft = 0.0;
    }

    // use swipe to swap teams
    if (details.delta.dx.abs() > 1) {
      _panPositionXLeft += details.delta.dx;
      if (_panPositionXLeft > 200) {
        _panPositionYLeft = 0.0;
        _swapTeams();
      }
    } else {
      _panPositionXLeft = 0.0;
    }
  }

  void _panUpdateRight(DragUpdateDetails details) async {
    // use swipe to adjust score
    if (details.delta.dy.abs() > 1) {
      _panPositionYRight += details.delta.dy;
      if (_panPositionYRight < -100) {
        _panPositionYRight = 0.0;
        _incrementRight();
      } else if (_panPositionYRight > 100) {
        _panPositionYRight = 0.0;
        _decrementRight();
      }
    } else {
      _panPositionYRight = 0.0;
    }

    // use swipe to swap teams
    if (details.delta.dx.abs() > 1) {
      _panPositionXRight += details.delta.dx;
      if (_panPositionXRight < -200) {
        _panPositionXRight = 0.0;
        _swapTeams();
      }
    } else {
      _panPositionXRight = 0.0;
    }
  }


  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Scaffold(
        backgroundColor: kInputPageBackgroundColor,
        body: Center(
          child: Container(
            width: kMainContainerWidthPortrait,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: TeamScoreCard(
                          onPress: _incrementLeft,
                          onPan: _panUpdateLeft,
                          color: kTeamCardColorLeft,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelLeft,
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueLeft).toString(),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TeamScoreCard(
                          onPress: _incrementRight,
                          onPan: _panUpdateRight,
                          color: kTeamCardColorRight,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelRight,
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueRight).toString(),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SettingsButton(
          onPress: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return SettingsModal(
                    onClear: _clearBoth,
                    onReset: _resetBoth,
                    onSwap: _swapTeams,
                    onDone: _saveBoth,
                  );
                },
                isScrollControlled: true,
              );
            }
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
    else {
      return Scaffold(
        backgroundColor: kInputPageBackgroundColor,
        body: Center(
          child: Container(
            width: kMainContainerWidthLandscape,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TeamScoreCard(
                          onPress: _incrementLeft,
                          onPan: _panUpdateLeft,
                          color: kTeamCardColorLeft,
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelLeft,
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueLeft).toString(),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TeamScoreCard(
                          onPress: _incrementRight,
                          onPan: _panUpdateRight,
                          color: kTeamCardColorRight,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelRight,
                                style: kLabelTextStyle,
                              ),
                              Text(
                                (_valueRight).toString(),
                                style: kNumberTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SettingsButton(
            onPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return SettingsModal(
                      onClear: _clearBoth,
                      onReset: _resetBoth,
                      onSwap: _swapTeams,
                      onDone: _saveBoth,
                    );
                  },
                  isScrollControlled: true,
              );
            }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
  }
}
