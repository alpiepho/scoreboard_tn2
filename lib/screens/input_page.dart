import 'package:flutter/material.dart';
// import 'package:flutter_material_pickers/flutter_material_pickers.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:unit_calculator/components/bottom_button.dart';
import 'package:scoreboard_tn/components/reusable_card.dart';
import 'package:scoreboard_tn/components/settings_button.dart';
// import 'package:unit_calculator/components/round_icon_button.dart';
import 'package:scoreboard_tn/constants.dart';
// import 'package:unit_calculator/screens/settings_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

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



  //
  // var selectedUnitSelect = "";
  // List<String> allUnitSelects = CalculatorEngine().getUnitTypeSelectList();
  //
  // _readPersistentData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final unitType = prefs.getInt('unitType') ?? 0;
  //   final valueLeft = prefs.getDouble('valueLeft') ?? 1.0;
  //   final valueRight = prefs.getDouble('valueRight') ?? 2.54;
  //   final tenX = prefs.getDouble('tenX') ?? 1.0;
  //   final twoX = prefs.getDouble('twoX') ?? 1.0;
  //   //print('_readPersistentData: $unitType');
  //   //print('_readPersistentData: valueLeft');
  //   //print('_readPersistentData: valueRight');
  //   //print('_readPersistentData: tenX');
  //   //print('_readPersistentData: twoX');
  //   setState(() {
  //     _unitType = unitType;
  //     _valueLeft = valueLeft;
  //     _valueRight = valueRight;
  //     _tenX = tenX;
  //     _twoX = twoX;
  //   });
  // }
  //
  // _savePersistentData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('unitType', _unitType);
  //   prefs.setDouble('valueLeft', _valueLeft);
  //   prefs.setDouble('valueRight', _valueRight);
  //   prefs.setDouble('tenX', _tenX);
  //   prefs.setDouble('twoX', _twoX);
  //   //print('_savePersistentData $_unitType');
  //   //print('_savePersistentData _valueLeft');
  //   //print('_savePersistentData _valueRight');
  //   //print('_savePersistentData _tenX');
  //   //print('_savePersistentData _twoX');
  // }
  //
  //

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
    setState(() {
      _valueLeft = 0;
      _valueRight = 0;
    });
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


  // void _updateValueLeftEtc(double newValue) {
  //   _valueLeft = newValue;
  //   _valueLeft = double.parse(_valueLeft.toStringAsFixed(2));
  //   _valueRight = _calc.convert(_unitType, _valueLeft);
  //   _valueRight = double.parse(_valueRight.toStringAsFixed(2));
  //   _savePersistentData();
  // }
  //
  // void _openUnitTypeDialog() async {
  //   showMaterialScrollPicker(
  //     backgroundColor: kActiveCardColour,
  //     headerColor: kActiveCardColour,
  //     showDivider: false,
  //     context: context,
  //     title: "Pick Unit Type",
  //     items: allUnitSelects,
  //     selectedItem: selectedUnitSelect,
  //     onChanged: (value) {
  //       if (value == 'google') {
  //         launch('https://www.google.com/search?q=meter+to+yard');
  //       }
  //       else {
  //         setState(() {
  //           selectedUnitSelect = value;
  //           _unitType = this._calc.decodeUnitTypeSelectString(selectedUnitSelect);
  //           if (_valueRight < this._calc.rangeMin(_unitType)) _valueRight = this._calc.rangeMin(_unitType);
  //           if (_valueRight > this._calc.rangeMax(_unitType)) _valueRight = this._calc.rangeMax(_unitType);
  //           _updateValueLeftEtc(_valueRight);
  //         });
  //       }
  //     },
  //   );
  // }
  //
  // void _moveToSettingsPage() async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => SettingsPage(
  //         unitType: _unitType,
  //       ),
  //     ),
  //   );
  //   if (result != null) {
  //     setState(() {
  //       _unitType = (result < _calc.maxUnits() ? result : 0);
  //       _updateValueLeftEtc(_valueRight);
  //     });
  //   }
  // }
  //
  // @override
  // initState() {
  //   super.initState();
  //   _readPersistentData();
  // }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    if (isPortrait) {
      return Scaffold(
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
                        child: ReusableCard(
                          onPress: _incrementLeft,
                          onPan: _panUpdateLeft,
                          color: kActiveCardColor,
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
                        child: ReusableCard(
                          onPress: _incrementRight,
                          onPan: _panUpdateRight,
                          color: kActiveCardColor,
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
          onPress: _clearBoth,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
    else {
      return Scaffold(
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
                        child: ReusableCard(
                          onPress: _incrementLeft,
                          onPan: _panUpdateLeft,
                          color: kActiveCardColor,
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
                        child: ReusableCard(
                          onPress: _incrementRight,
                          onPan: _panUpdateRight,
                          color: kActiveCardColor,
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
          onPress: _clearBoth,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
  }
}
