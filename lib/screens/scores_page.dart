import 'package:flutter/material.dart';
import 'package:scoreboard_tn/components/score_card.dart';
import 'package:scoreboard_tn/components/settings_button.dart';
import 'package:scoreboard_tn/components/settings_modal.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:scoreboard_tn/engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoresPage extends StatefulWidget {
  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {

  //
  // for display
  //
  Color _colorTextLeft = Colors.black;
  Color _colorBackgroundLeft = Colors.red;
  Color _colorTextRight = Colors.black;
  Color _colorBackgroundRight = Colors.blueAccent;

  String _labelLeft = "Away";
  String _labelRight = "Home";
  int _valueLeft = 0;
  int _valueRight = 0;

  // for increment/decrement swiping
  double _panPositionYLeft = 0.0;
  double _panPositionYRight = 0.0;

  Engine _engine = Engine();


  // _readPersistentData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final labelLeft = prefs.getString('labelLeft') ?? 'Away';
  //   final labelRight = prefs.getString('labelRight') ?? 'Home';
  //   final valueLeft = prefs.getInt('valueLeft') ?? 0;
  //   final valueRight = prefs.getInt('valueRight') ?? 0;
  //   setState(() {
  //     _labelLeft = labelLeft;
  //     _labelRight = labelRight;
  //     _valueLeft = valueLeft;
  //     _valueRight = valueRight;
  //   });
  // }
  //
  // _savePersistentData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('labelLeft', _labelLeft);
  //   prefs.setString('labelRight', _labelRight);
  //   prefs.setInt('valueLeft', _valueLeft);
  //   prefs.setInt('valueRight', _valueRight);
  // }

  void _fromEngine() async {
    setState(() {
      _colorTextLeft = this._engine.colorTextLeft;
      _colorBackgroundLeft = this._engine.colorBackgroundLeft;
      _colorTextRight = this._engine.colorTextRight;
      _colorBackgroundRight = this._engine.colorBackgroundRight;

      _labelLeft  = this._engine.labelLeft;
      _labelRight = this._engine.labelRight;
      _valueLeft = this._engine.valueLeft;
      _valueRight = this._engine.valueRight;
    });
  }

  void _incrementLeft() async {
    this._engine.incrementLeft();
    _fromEngine();
  }

  void _decrementLeft() async {
    this._engine.decrementLeft();
    _fromEngine();
  }

  void _incrementRight() async {
    this._engine.incrementRight();
    _fromEngine();
  }

  void _decrementRight() async {
    this._engine.decrementRight();
    _fromEngine();
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
                this._engine.clearBoth();
                _fromEngine();
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
                this._engine.resetBoth();
                _fromEngine();
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
    this._engine.swapTeams();
    _fromEngine();
    Navigator.of(context).pop();
  }

  void _saveBoth() async {
    this._engine.saveBoth();
    _fromEngine();
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
                          color: _colorBackgroundLeft,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelLeft,
                                style: kLabelTextStyle.copyWith(color: _colorTextLeft),
                              ),
                              Text(
                                (_valueLeft).toString(),
                                style: kNumberTextStyle.copyWith(color: _colorTextLeft),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TeamScoreCard(
                          onPress: _incrementRight,
                          onPan: _panUpdateRight,
                          color: _colorBackgroundRight,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelRight,
                                style: kLabelTextStyle.copyWith(color: _colorTextRight),
                              ),
                              Text(
                                (_valueRight).toString(),
                                style: kNumberTextStyle.copyWith(color: _colorTextRight),
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
            this._engine.setNew();
            showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return SettingsModal(
                    context,
                    this._engine,
                    _resetBoth,
                    _clearBoth,
                    _swapTeams,
                    _saveBoth,
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
                          color: _colorBackgroundLeft,
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelLeft,
                                style: kLabelTextStyle.copyWith(color: _colorTextLeft),
                              ),
                              Text(
                                (_valueLeft).toString(),
                                style: kNumberTextStyle.copyWith(color: _colorTextLeft),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TeamScoreCard(
                          onPress: _incrementRight,
                          onPan: _panUpdateRight,
                          color: _colorBackgroundRight,
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelRight,
                                style: kLabelTextStyle.copyWith(color: _colorTextRight),
                              ),
                              Text(
                                (_valueRight).toString(),
                                style: kNumberTextStyle.copyWith(color: _colorTextRight),
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
              this._engine.setNew();
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return SettingsModal(
                      context,
                      this._engine,
                      _resetBoth,
                      _clearBoth,
                      _swapTeams,
                      _saveBoth,
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
