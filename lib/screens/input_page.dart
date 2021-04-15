import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  Color _colorTextLeft = Colors.black;
  Color _colorBackgroundLeft = Colors.red;
  Color _colorTextRight = Colors.black;
  Color _colorBackgroundRight = Colors.blueAccent;

  String _labelLeft = "Away";
  String _labelRight = "Home";
  int _valueLeft = 0;
  int _valueRight = 0;

  double _panPositionYLeft = 0.0;
  double _panPositionYRight = 0.0;

  String _newLabelLeft = "";
  String _newLabelRight = "";
  int _newValueLeft = 0;
  int _newValueRight = 0;
  Color _newColorTextLeft = Colors.black;
  Color _newColorBackgroundLeft = Colors.red;
  Color _newColorTextRight = Colors.black;
  Color _newColorBackgroundRight = Colors.blueAccent;


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
                  _colorTextLeft = Colors.black;
                  _colorBackgroundLeft = Colors.red;
                  _colorTextRight = Colors.black;
                  _colorBackgroundRight = Colors.blueAccent;
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
    setState(() {
      _labelLeft = _newLabelLeft;
      _labelRight = _newLabelRight;
      _valueLeft = _newValueLeft;
      _valueRight = _newValueRight;
      _colorTextLeft = _newColorTextLeft;
      _colorBackgroundLeft = _newColorBackgroundLeft;
      _colorTextRight = _newColorTextRight;
      _colorBackgroundRight = _newColorBackgroundRight;
    });
    Navigator.of(context).pop();
  }

  void _labelLeftChanged(String text) async {
    setState(() {
      _newLabelLeft = text;
    });
  }

  void _labelRightChanged(String text) async {
    setState(() {
      _newLabelRight = text;
    });
  }

  void _valueLeftChanged(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        _newValueLeft = int.parse(text);
        if (_newValueLeft < 0) _newValueLeft = 0;
      });
    }
  }

  void _valueRightChanged(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        _newValueRight = int.parse(text);
        if (_newValueRight < 0) _newValueRight = 0;
      });
    }
  }

  void _colorTextLeftChanged(Color color) async {
    setState(() {
      _newColorTextLeft = color;
    });
  }

  void _colorBackgroundLeftChanged(Color color) async {
    setState(() {
      _newColorBackgroundLeft = color;
    });
  }

  void _colorTextRightChanged(Color color) async {
    setState(() {
      _newColorTextRight = color;
    });
  }

  void _colorBackgroundRightChanged(Color color) async {
    setState(() {
      _newColorBackgroundRight = color;
    });
  }

  void _colorTextLeftEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _colorTextLeft,
              onColorChanged: _colorTextLeftChanged,
              //showLabel: true,
              //pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                //setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _colorBackgroundLeftEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _colorBackgroundLeft,
              onColorChanged: _colorBackgroundLeftChanged,
              //showLabel: true,
              //pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                //setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _colorTextRightEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _colorTextRight,
              onColorChanged: _colorTextRightChanged,
              //showLabel: true,
              //pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                //setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _colorBackgroundRightEdit() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _colorBackgroundRight,
              onColorChanged: _colorBackgroundRightChanged,
              //showLabel: true,
              //pickerAreaHeightPercent: 0.8,
            ),
            // Use Material color picker:
            //
            // child: MaterialPicker(
            //   pickerColor: pickerColor,
            //   onColorChanged: changeColor,
            //   showLabel: true, // only on portrait mode
            // ),
            //
            // Use Block color picker:
            //
            // child: BlockPicker(
            //   pickerColor: currentColor,
            //   onColorChanged: changeColor,
            // ),
            //
            // child: MultipleChoiceBlockPicker(
            //   pickerColors: currentColors,
            //   onColorsChanged: changeColors,
            // ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                //setState(() => currentColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            setState(() {
              _newLabelLeft = _labelLeft;
              _newLabelRight = _labelRight;
              _newValueLeft = _valueLeft;
              _newValueRight = _valueRight;
              _newColorTextLeft = _colorTextLeft;
              _newColorBackgroundLeft = _newColorBackgroundLeft;
              _newColorBackgroundRight = _newColorBackgroundRight;
            });
            showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return SettingsModal(
                    labelLeft: _labelLeft,
                    labelRight: _labelRight,
                    valueLeft: _valueLeft.toString(),
                    valueRight: _valueRight.toString(),
                    colorTextLeft: _colorTextLeft,
                    colorBackgroundLeft: _colorBackgroundLeft,
                    colorTextRight: _colorTextRight,
                    colorBackgroundRight: _colorBackgroundRight,
                    onClear: _clearBoth,
                    onReset: _resetBoth,
                    onSwap: _swapTeams,
                    onDone: _saveBoth,
                    labelLeftChanged: _labelLeftChanged,
                    labelRightChanged: _labelRightChanged,
                    valueLeftChanged: _valueLeftChanged,
                    valueRightChanged: _valueRightChanged,
                    colorTextLeftEdit: _colorTextLeftEdit,
                    colorBackgroundLeftEdit: _colorBackgroundLeftEdit,
                    colorTextRightEdit: _colorTextRightEdit,
                    colorBackgroundRightEdit: _colorBackgroundRightEdit,
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
              setState(() {
                _newLabelLeft = _labelLeft;
                _newLabelRight = _labelRight;
                _newValueLeft = _valueLeft;
                _newValueRight = _valueRight;
                _newColorTextLeft = _colorTextLeft;
                _newColorBackgroundLeft = _newColorBackgroundLeft;
                _newColorBackgroundRight = _newColorBackgroundRight;
              });
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return SettingsModal(
                      labelLeft: _labelLeft,
                      labelRight: _labelRight,
                      valueLeft: _valueLeft.toString(),
                      valueRight: _valueRight.toString(),
                      colorTextLeft: _colorTextLeft,
                      colorBackgroundLeft: _colorBackgroundLeft,
                      colorTextRight: _colorTextRight,
                      colorBackgroundRight: _colorBackgroundRight,
                      onClear: _clearBoth,
                      onReset: _resetBoth,
                      onSwap: _swapTeams,
                      onDone: _saveBoth,
                      labelLeftChanged: _labelLeftChanged,
                      labelRightChanged: _labelRightChanged,
                      valueLeftChanged: _valueLeftChanged,
                      valueRightChanged: _valueRightChanged,
                      colorTextLeftEdit: _colorTextLeftEdit,
                      colorBackgroundLeftEdit: _colorBackgroundLeftEdit,
                      colorTextRightEdit: _colorTextRightEdit,
                      colorBackgroundRightEdit: _colorBackgroundRightEdit,
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
