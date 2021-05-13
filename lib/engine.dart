import 'package:flutter/material.dart';
import 'package:scoreboard_tn/constants.dart';

class Engine {
  Color colorTextLeft = Colors.black;
  Color colorBackgroundLeft = Colors.red;
  Color colorTextRight = Colors.black;
  Color colorBackgroundRight = Colors.blueAccent;

  String labelLeft = "Away";
  String labelRight = "Home";
  int valueLeft = 0;
  int valueRight = 0;

  bool earnedEnabled = false;
  bool earnedVisible = false;
  int earnedLeft = 0;
  int earnedRight = 0;

  String newLabelLeft = "";
  String newLabelRight = "";
  int newValueLeft = 0;
  int newValueRight = 0;
  Color newColorTextLeft = Colors.black;
  Color newColorBackgroundLeft = Colors.red;
  Color newColorTextRight = Colors.black;
  Color newColorBackgroundRight = Colors.blueAccent;

  FontTypes fontType = FontTypes.system;

  String recordingRate = "Normal";
  bool recordingEnabled = false;
  DateTime recordingStart = DateTime.now();
  String recording = "";
  String recordingYTLink = "";

  Engine();

  //
  // pack/unpack
  //
  String pack() {
    String result = "";

    result += colorTextLeft.toString() + ";";
    result += colorBackgroundLeft.toString() + ";";
    result += colorTextRight.toString() + ";";
    result += colorBackgroundRight.toString() + ";";

    result += labelLeft.toString() + ";";
    result += labelRight.toString() + ";";
    result += valueLeft.toString() + ";";
    result += valueRight.toString() + ";";

    result += earnedEnabled.toString() + ";";
    result += earnedVisible.toString() + ";";
    result += earnedLeft.toString() + ";";
    result += earnedRight.toString() + ";";

    result += fontType.toString() + ";";

    return result;
  }

  Color stringToColor(String code) {
    // .... Color(0xff000000)
    var parts = code.split("0x");
    var s = parts[1].substring(0, 8);
    var h = int.parse(s, radix: 16);
    return new Color(h);
  }

  void unpack(String packed) {
    if (packed.length == 0)
      return;

    var parts = packed.split(";");
    int index = 0;

    colorTextLeft = stringToColor(parts[index++]);
    colorBackgroundLeft = stringToColor(parts[index++]);
    colorTextRight = stringToColor(parts[index++]);
    colorBackgroundRight = stringToColor(parts[index++]);

    labelLeft = parts[index++];
    labelRight = parts[index++];
    valueLeft = int.parse(parts[index++]);
    valueRight = int.parse(parts[index++]);

    earnedEnabled = parts[index++] == "true";
    earnedVisible = parts[index++] == "true";
    earnedLeft = int.parse(parts[index++]);
    earnedRight = int.parse(parts[index++]);

    fontType = FontTypes.system;
    for (var value in FontTypes.values) {
      if (value.toString() == parts[index]) {
        fontType = value;
        break;
      }
    }
    index++;

    colorTextLeft = colorTextLeft;
    colorBackgroundLeft = colorBackgroundLeft;
    colorTextRight = colorTextRight;
    colorBackgroundRight = colorBackgroundRight;

    newColorTextLeft = colorTextLeft;
    newColorBackgroundLeft = colorBackgroundLeft;
    newColorTextRight = colorTextRight;
    newColorBackgroundRight = colorBackgroundRight;
  }

  //
  // Getter/Setters for temporary variables
  //
  set newValueLeftString(String text) {
    if (text.isNotEmpty) {
      newValueLeft = int.parse(text);
      if (newValueLeft < 0) newValueLeft = 0;
    }
  }

  set newValueRightString(String text) {
    if (text.isNotEmpty) {
      newValueRight = int.parse(text);
      if (newValueRight < 0) newValueRight = 0;
    }
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
    switch(recordingRate) {
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

  void incrementLeft(bool earned) {
    valueLeft += 1;
    if (earned) {
      earnedLeft += 1;
    }
    _timestampRecordingAdd();
  }

  void decrementLeft(bool earned) {
    valueLeft -= 1;
    if (valueLeft < 0) valueLeft = 0;
    if (earned) {
      earnedLeft -= 1;
      if (earnedLeft < 0) earnedLeft = 0;
    }
    _timestampRecordingAdd();
  }

  void incrementRight(bool earned) {
    valueRight += 1;
    if (earned) {
      earnedRight += 1;
    }
    _timestampRecordingAdd();
  }

  void decrementRight(bool earned) {
    valueRight -= 1;
    if (valueRight < 0) valueRight = 0;
    if (earned) {
      earnedRight -= 1;
      if (earnedRight < 0) earnedRight = 0;
    }
    _timestampRecordingAdd();
  }

  void clearBoth() {
    valueLeft = 0;
    valueRight = 0;
    earnedLeft = 0;
    earnedRight = 0;
    _timestampRecordingAdd();
  }

  void resetBoth()  {
    labelLeft = "Away";
    labelRight = "Home";
    valueLeft = 0;
    valueRight = 0;
    earnedLeft = 0;
    earnedRight = 0;
    colorTextLeft = Colors.black;
    colorBackgroundLeft = Colors.red;
    colorTextRight = Colors.black;
    colorBackgroundRight = Colors.blueAccent;
    newColorTextLeft = colorTextLeft;
    newColorBackgroundLeft = colorBackgroundLeft;
    newColorTextRight = colorTextRight;
    newColorBackgroundRight = colorBackgroundRight;
    fontType = FontTypes.system;
  }

  void swapTeams() {
    var valueTemp = valueLeft;
    valueLeft = valueRight;
    valueRight = valueTemp;
    valueTemp = earnedLeft;
    earnedLeft = earnedRight;
    earnedRight = valueTemp;
    var labelTemp = labelLeft;
    labelLeft = labelRight;
    labelRight = labelTemp;
    var colorTemp = colorTextLeft;
    colorTextLeft = colorTextRight;
    colorTextRight = colorTemp;
    colorTemp = colorBackgroundLeft;
    colorBackgroundLeft = colorBackgroundRight;
    colorBackgroundRight = colorTemp;
  }

  void saveBoth() {
    labelLeft = newLabelLeft;
    labelRight = newLabelRight;
    valueLeft = newValueLeft;
    valueRight = newValueRight;
    colorTextLeft = newColorTextLeft;
    colorBackgroundLeft = newColorBackgroundLeft;
    colorTextRight = newColorTextRight;
    colorBackgroundRight = newColorBackgroundRight;
  }

  void setNew() {
    newLabelLeft = labelLeft;
    newLabelRight = labelRight;
    newValueLeft = valueLeft;
    newValueRight = valueRight;
    newColorTextLeft = colorTextLeft;
    newColorBackgroundLeft = newColorBackgroundLeft;
    newColorBackgroundRight = newColorBackgroundRight;
  }

  void timestampRecordingStart() {
    recordingEnabled = true;
    recording = "00:00:00 Start\n";
    recordingStart = DateTime.now();
  }

  void timestampRecordingStop() {
    recordingEnabled = false;
  }

  String timestampRecordingCopy() {
    //print(recording);
    return recording;
  }

  _timestampFormat(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  void _timestampRecordingAdd() {
    if (recordingEnabled) {
      final rate = convertRate();
      final difference = DateTime.now().difference(recordingStart) * rate;
      if (this.earnedEnabled) {
        String ts = _timestampFormat(new Duration(seconds: difference.inSeconds)) + " ";
        recording += ts + "actual:" + labelLeft + " " + valueLeft.toString() + ", " + labelRight + " " + valueRight.toString();
        recording +=      "   earned:" + labelLeft + " " + earnedLeft.toString() + ", " + labelRight + " " + earnedRight.toString() + "\n";
      } else {
        String ts = _timestampFormat(new Duration(seconds: difference.inSeconds)) + " ";
        recording += ts + labelLeft + " " + valueLeft.toString() + ", " + labelRight + " " + valueRight.toString() + "\n";
      }
    }
  }

  String timestampRecordingYTText() {
    String results = "";

    // recordingYTLink could be in one of the following forms:
    // https://www.youtube.com/watch?v=k70vuZ5oDo0
    // https://youtu.be/k70vuZ5oDo0?t=119
    var v = "";
    var parts;
    // get v guid ie. k70vuZ5oDo0
    if (recordingYTLink.contains("?v=")) {
      parts = recordingYTLink.split("?v=");
      v = parts[1];
    }
    else {
      parts = recordingYTLink.replaceAll("https://youtu.be/", "").split("?t=");
      v = parts[0];
    }

    // for each line of recording
    var lines = recording.split("\n");
    for (String line in lines) {
      if (line.length == 0) {
        break;
      }
      // convert nn:nn:nn to seconds
      parts = line.split(" ");
      var tsparts = parts[0].split(":");
      var ts = 0;
      ts += int.parse(tsparts[0])*60*60;
      ts += int.parse(tsparts[1])*60;
      ts += int.parse(tsparts[2]);

      // build prefix with "https://youtu.be/" + v + "t=" + seconds
      // add new line of prefix + delimiter(tab?) + oldline
      results += "https://youtu.be/" + v + "?t=" + ts.toString() + "\n";

    }
    return results;
  }
}
