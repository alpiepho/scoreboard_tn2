import 'package:flutter/material.dart';
import 'package:scoreboard_tn/constants.dart';

class Score {
  int valueLeft = 0;
  int valueRight = 0;
  int earnedLeft = 0;
  int earnedRight = 0;
}

class Engine {
  Color _colorTextLeft = Colors.black;
  Color _colorBackgroundLeft = Colors.red;
  Color _colorTextRight = Colors.black;
  Color _colorBackgroundRight = Colors.blueAccent;

  String _labelLeft = "Away";
  String _labelRight = "Home";
  int _valueLeft = 0;
  int _valueRight = 0;

  bool _earnedEnabled = false;
  bool _earnedVisible = false;
  int _earnedLeft = 0;
  int _earnedRight = 0;

  String _newLabelLeft = "";
  String _newLabelRight = "";
  int _newValueLeft = 0;
  int _newValueRight = 0;
  Color _newColorTextLeft = Colors.black;
  Color _newColorBackgroundLeft = Colors.red;
  Color _newColorTextRight = Colors.black;
  Color _newColorBackgroundRight = Colors.blueAccent;

  FontTypes _fontType = FontTypes.system;

  bool _recordingEnabled = false;
  DateTime _recordingStart = DateTime.now();
  String _recording = "";
  String _recordingRate = "Normal";

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

  bool get earnedEnabled => _earnedEnabled;

  set earnedEnabled(bool value) {
    _earnedEnabled = value;
  }

  bool get earnedVisible => _earnedVisible;

  set earnedVisible(bool value) {
    _earnedVisible = value;
  }

  int get earnedLeft => _earnedLeft;

  set earnedLeft(int value) {
    _earnedLeft = value;
  }

  int get earnedRight => _earnedRight;

  set earnedRight(int value) {
    _earnedRight = value;
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

  String get recordingRate => _recordingRate;

  set recordingRate(String value) {
    _recordingRate = value;
  }

  //
  // Public methods
  //

  List<String> getRates() {
    List<String> results = List.empty(growable: true);
    results.add("0.25");
    results.add("0.5");
    results.add("0.75");
    results.add("Normal");
    results.add("1.25");
    results.add("1.5");
    results.add("1.75");
    results.add("2");
    return results;
  }

  double convertRate() {
    double result = 1.0;
    switch(_recordingRate) {
      case "0.25": result = 0.25; break;
      case "0.5": result = 0.5; break;
      case "0.75": result = 0.75; break;
      case "Normal": result = 1.0; break;
      case "1.25": result = 1.25; break;
      case "1.5": result = 1.5; break;
      case "1.75": result = 1.75; break;
      case "2": result = 2.0; break;
    }
    return result;
  }

  //TODO need stack of scores to properly decrement
  //TODO replace intenal _value* _earned* using stack
  //TODO persist stack
  void incrementLeft(bool earned) {
    _valueLeft += 1;
    if (earned) {
      _earnedLeft += 1;
    }
    _timestampRecordingAdd();
  }

  void decrementLeft(bool earned) {
    _valueLeft -= 1;
    if (_valueLeft < 0) _valueLeft = 0;
    if (earned) {
      _earnedLeft -= 1;
      if (_earnedLeft < 0) _earnedLeft = 0;
    }
    _timestampRecordingAdd();
  }

  void incrementRight(bool earned) {
    _valueRight += 1;
    if (earned) {
      _earnedRight += 1;
    }
    _timestampRecordingAdd();
  }

  void decrementRight(bool earned) {
    _valueRight -= 1;
    if (_valueRight < 0) _valueRight = 0;
    if (earned) {
      _earnedRight -= 1;
      if (_earnedRight < 0) _earnedRight = 0;
    }
    _timestampRecordingAdd();
  }

  void clearBoth() {
    _valueLeft = 0;
    _valueRight = 0;
    _earnedLeft = 0;
    _earnedRight = 0;
    _timestampRecordingAdd();
  }

  void resetBoth()  {
    _labelLeft = "Away";
    _labelRight = "Home";
    _valueLeft = 0;
    _valueRight = 0;
    _earnedLeft = 0;
    _earnedRight = 0;
    _colorTextLeft = Colors.black;
    _colorBackgroundLeft = Colors.red;
    _colorTextRight = Colors.black;
    _colorBackgroundRight = Colors.blueAccent;
    _newColorTextLeft = _colorTextLeft;
    _newColorBackgroundLeft = _colorBackgroundLeft;
    _newColorTextRight = _colorTextRight;
    _newColorBackgroundRight = _colorBackgroundRight;
    fontType = FontTypes.system;
  }

  void swapTeams() {
    var valueTemp = _valueLeft;
    _valueLeft = _valueRight;
    _valueRight = valueTemp;
    valueTemp = _earnedLeft;
    _earnedLeft = _earnedRight;
    _earnedRight = valueTemp;
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

  void timestampRecordingStart() {
    _recordingEnabled = true;
    _recording = "00:00 Start\n";
    _recordingStart = DateTime.now();
  }

  void timestampRecordingStop() {
    _recordingEnabled = false;
  }

  String timestampRecordingCopy() {
    print(_recording);
    return _recording;
  }

  _timestampFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void _timestampRecordingAdd() {
    if (_recordingEnabled) {
      final rate = convertRate();
      final difference = DateTime.now().difference(_recordingStart) * rate;
      if (this.earnedEnabled) {
        String ts = _timestampFormat(new Duration(seconds: difference.inSeconds)) + " ";
        _recording += ts + "actual:" + _labelLeft + " " + _valueLeft.toString() + ", " + _labelRight + " " + _valueRight.toString();
        _recording +=      "   earned:" + _labelLeft + " " + _earnedLeft.toString() + ", " + _labelRight + " " + _earnedRight.toString() + "\n";
      } else {
        String ts = _timestampFormat(new Duration(seconds: difference.inSeconds)) + " ";
        _recording += ts + _labelLeft + " " + _valueLeft.toString() + ", " + _labelRight + " " + _valueRight.toString() + "\n";
      }
    }
  }

}
