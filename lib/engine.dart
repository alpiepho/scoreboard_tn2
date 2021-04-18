import 'package:flutter/material.dart';
import 'package:scoreboard_tn/constants.dart';

class Engine {
  Color _colorTextLeft = Colors.black;
  Color _colorBackgroundLeft = Colors.red;
  Color _colorTextRight = Colors.black;
  Color _colorBackgroundRight = Colors.blueAccent;

  String _labelLeft = "Away";
  String _labelRight = "Home";
  int _valueLeft = 0;
  int _valueRight = 0;

  String _newLabelLeft = "";
  String _newLabelRight = "";
  int _newValueLeft = 0;
  int _newValueRight = 0;
  Color _newColorTextLeft = Colors.black;
  Color _newColorBackgroundLeft = Colors.red;
  Color _newColorTextRight = Colors.black;
  Color _newColorBackgroundRight = Colors.blueAccent;

  FontTypes _fontType = FontTypes.system;

  Engine();

  //
  // Getter/Setters for main variables
  //
  Color get colorTextLeft => _colorTextLeft;

  set colorTextLeft(Color value) {
    _colorTextLeft = value;
  }

  Color get colorBackgroundLeft => _colorBackgroundLeft;

  set colorBackgroundLeft(Color value) {
    _colorBackgroundLeft = value;
  }

  Color get colorTextRight => _colorTextRight;

  set colorTextRight(Color value) {
    _colorTextRight = value;
  }

  Color get colorBackgroundRight => _colorBackgroundRight;

  set colorBackgroundRight(Color value) {
    _colorBackgroundRight = value;
  }

  String get labelLeft => _labelLeft;

  set labelLeft(String value) {
    _labelLeft = value;
  }

  String get labelRight => _labelRight;

  set labelRight(String value) {
    _labelRight = value;
  }

  int get valueLeft => _valueLeft;

  set valueLeft(int value) {
    _valueLeft = value;
  }

  int get valueRight => _valueRight;

  set valueRight(int value) {
    _valueRight = value;
  }

  String get newLabelLeft => _newLabelLeft;

  set newLabelLeft(String value) {
    _newLabelLeft = value;
  }

  FontTypes get fontType => _fontType;

  set fontType(FontTypes value) {
    _fontType = value;
  }



  //
  // Getter/Setters for temporary variables
  //
  String get newLabelRight => _newLabelRight;

  set newLabelRight(String value) {
    _newLabelRight = value;
  }

  int get newValueLeft => _newValueLeft;

  set newValueLeft(int value) {
    _newValueLeft = value;
  }

  set newValueLeftString(String text) {
    if (text.isNotEmpty) {
      _newValueLeft = int.parse(text);
      if (_newValueLeft < 0) _newValueLeft = 0;
    }
  }

  int get newValueRight => _newValueRight;

  set newValueRight(int value) {
    _newValueRight = value;
  }

  set newValueRightString(String text) {
    if (text.isNotEmpty) {
      _newValueRight = int.parse(text);
      if (_newValueRight < 0) _newValueRight = 0;
    }
  }

  Color get newColorTextLeft => _newColorTextLeft;

  set newColorTextLeft(Color value) {
    _newColorTextLeft = value;
  }

  Color get newColorBackgroundLeft => _newColorBackgroundLeft;

  set newColorBackgroundLeft(Color value) {
    _newColorBackgroundLeft = value;
  }

  Color get newColorTextRight => _newColorTextRight;

  set newColorTextRight(Color value) {
    _newColorTextRight = value;
  }

  Color get newColorBackgroundRight => _newColorBackgroundRight;

  set newColorBackgroundRight(Color value) {
    _newColorBackgroundRight = value;
  }

  //
  // Public methods
  //
  void incrementLeft() {
    _valueLeft += 1;
  }

  void decrementLeft() {
    _valueLeft -= 1;
    if (_valueLeft < 0) _valueLeft = 0;
  }

  void incrementRight() {
    _valueRight += 1;
  }

  void decrementRight() {
    _valueRight -= 1;
    if (_valueRight < 0) _valueRight = 0;
  }

  void clearBoth() {
    _valueLeft = 0;
    _valueRight = 0;
  }

  void resetBoth()  {
    _labelLeft = "Away";
    _labelRight = "Home";
    _valueLeft = 0;
    _valueRight = 0;
    _colorTextLeft = Colors.black;
    _colorBackgroundLeft = Colors.red;
    _colorTextRight = Colors.black;
    _colorBackgroundRight = Colors.blueAccent;
    fontType = FontTypes.system;
  }

  void swapTeams() {
    var valueTemp = _valueLeft;
    _valueLeft = _valueRight;
    _valueRight = valueTemp;
    var labelTemp = _labelLeft;
    _labelLeft = _labelRight;
    _labelRight = labelTemp;
    var colorTemp = _colorTextLeft;
    _colorTextLeft = _colorTextRight;
    _colorTextRight = colorTemp;
    colorTemp = _colorBackgroundLeft;
    _colorBackgroundLeft = _colorBackgroundRight;
    _colorBackgroundRight = colorTemp;
  }

  void saveBoth() {
    _labelLeft = _newLabelLeft;
    _labelRight = _newLabelRight;
    _valueLeft = _newValueLeft;
    _valueRight = _newValueRight;
    _colorTextLeft = _newColorTextLeft;
    _colorBackgroundLeft = _newColorBackgroundLeft;
    _colorTextRight = _newColorTextRight;
    _colorBackgroundRight = _newColorBackgroundRight;
  }

  void setNew() {
    _newLabelLeft = _labelLeft;
    _newLabelRight = _labelRight;
    _newValueLeft = _valueLeft;
    _newValueRight = _valueRight;
    _newColorTextLeft = _colorTextLeft;
    _newColorBackgroundLeft = _newColorBackgroundLeft;
    _newColorBackgroundRight = _newColorBackgroundRight;
  }
}