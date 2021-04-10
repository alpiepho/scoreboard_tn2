import 'package:flutter/material.dart';
// import 'package:flutter_material_pickers/flutter_material_pickers.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:unit_calculator/components/bottom_button.dart';
import 'package:scoreboard_tn/components/reusable_card.dart';
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

  double _dragStartPositionLeft = 0.0;
  double _dragStartPositionRight = 0.0;


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

  void _clearLeft() async {
    setState(() {
      _valueLeft = 0;
    });
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

  void _clearRight() async {
    setState(() {
      _valueRight = 0;
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

  void _dragStartLeft() async {

  }

  void _dragEndLeft() async {

  }

  void _dragStartRight() async {

  }

  void _dragEndRight() async {

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
                          onDragStart: null,
                          onDragEnd: null,
                          color: kActiveCardColour,
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
                          color: kActiveCardColour,
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
        floatingActionButton: Container(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            onPressed: _clearBoth,
            tooltip: 'Settings',
            child: Icon(Icons.settings, size: 50),
          ),
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
                          color: kActiveCardColour,
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
                          color: kActiveCardColour,
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
        floatingActionButton: Container(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            onPressed: _clearBoth,
            tooltip: 'Settings',
            child: Icon(Icons.settings, size: 50),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
  }
}
