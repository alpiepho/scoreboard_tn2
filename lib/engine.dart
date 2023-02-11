import 'package:flutter/material.dart';
import '../constants.dart';

class Engine {
  Color colorTextLeft = Colors.black;
  Color colorBackgroundLeft = Colors.red;
  Color colorTextRight = Colors.black;
  Color colorBackgroundRight = Colors.blueAccent;

  String labelLeft = "Away";
  String labelRight = "Home";
  int valueLeft = 0;
  int valueRight = 0;

  String pendingLabelLeft = "";
  String pendingLabelRight = "";
  Color pendingColorTextLeft = Colors.black;
  Color pendingColorBackgroundLeft = Colors.red;
  Color pendingColorTextRight = Colors.black;
  Color pendingColorBackgroundRight = Colors.blueAccent;

  FontTypes fontType = FontTypes.system;

  bool notify7Enabled = false;
  bool notify8Enabled = false;
  bool lastPointLeft = false;
  bool lastPointEnabled = true;
  bool zoom = false;
  bool setsShow = false;
  bool sets5 = false;
  int setsLeft = 0;
  int setsRight = 0;

  String scoreKeeper = ""; // can be comma separated list or *
  String reflectorSite = "";
  List<String> savedTeams = [];

  String reflectorSiteTest = "http://localhost:3000";
  String reflectorSiteDefault = "https://refelectortn2.uw.r.appspot.com";

  // not saved
  String reflectorComment = "";
  String possibleKeepers = "";

  Engine();

  //
  // pack/unpack
  //
  String pack() {
    String result = "";

    result += kVersion + ";";

    result += colorTextLeft.toString() + ";";
    result += colorBackgroundLeft.toString() + ";";
    result += colorTextRight.toString() + ";";
    result += colorBackgroundRight.toString() + ";";

    result += labelLeft.toString() + ";";
    result += labelRight.toString() + ";";
    result += valueLeft.toString() + ";";
    result += valueRight.toString() + ";";

    result += "removed" + ";";
    result += "removed" + ";";
    result += "removed" + ";";
    result += "removed" + ";";

    result += fontType.toString() + ";";

    result += "removed" + ";"; // was forceLandscape
    result += notify7Enabled.toString() + ";";
    result += notify8Enabled.toString() + ";";

    result += lastPointLeft.toString() + ";";
    result += lastPointEnabled.toString() + ";";

    result += zoom.toString() + ";";
    result += setsShow.toString() + ";";
    result += sets5.toString() + ";";
    result += setsLeft.toString() + ";";
    result += setsRight.toString() + ";";

    result += scoreKeeper.toString() + ";";
    result += reflectorSite.toString() + ";";

    result += savedTeams.join("__");

    return result;
  }

  Color stringToColor(String code) {
    // .... Color(0xff000000)
    var parts = code.split("0x");
    var s = parts[1].substring(0, 8);
    var h = int.parse(s, radix: 16);
    return new Color(h);
  }

  FontTypes stringToFont(String name) {
    var fontType = FontTypes.system;

    for (var value in FontTypes.values) {
      if (value.toString() == name) {
        fontType = value;
        break;
      }
    }
    return fontType;
  }

  void unpack(String packed) {
    if (packed.length == 0) return;

    var parts = packed.split(";");
    int index = 0;

    bool versionFound = false;
    if (parts[0].contains("Version")) {
      versionFound = true; // remove afer version 2.2j
      index++;
    }
    print("unpack version found: " + versionFound.toString());

    if (index < parts.length) colorTextLeft = stringToColor(parts[index++]);
    if (index < parts.length)
      colorBackgroundLeft = stringToColor(parts[index++]);
    if (index < parts.length) colorTextRight = stringToColor(parts[index++]);
    if (index < parts.length)
      colorBackgroundRight = stringToColor(parts[index++]);

    if (index < parts.length) labelLeft = parts[index++];
    if (index < parts.length) labelRight = parts[index++];
    if (index < parts.length) valueLeft = int.parse(parts[index++]);
    if (index < parts.length) valueRight = int.parse(parts[index++]);

    index++;
    index++;
    index++;
    index++;

    fontType = FontTypes.system;
    if (index < parts.length) {
      for (var value in FontTypes.values) {
        if (value.toString() == parts[index]) {
          fontType = value;
          break;
        }
      }
      index++;
    }

    index++; // was forceLandscape
    if (index < parts.length) notify7Enabled = parts[index++] == "true";
    if (index < parts.length) notify8Enabled = parts[index++] == "true";

    if (index < parts.length) lastPointLeft = parts[index++] == "true";
    if (index < parts.length) lastPointEnabled = parts[index++] == "true";

    // new since last release so check index
    if (index < parts.length) zoom = parts[index++] == "true";
    if (index < parts.length) setsShow = parts[index++] == "true";
    if (index < parts.length) sets5 = parts[index++] == "true";
    if (index < parts.length) setsLeft = int.parse(parts[index++]);
    if (index < parts.length) setsRight = int.parse(parts[index++]);

    if (index < parts.length) scoreKeeper = parts[index++];
    if (index < parts.length) reflectorSite = parts[index++];

    if (index < parts.length) {
      var temp = parts[index++];
      if (temp.length > 0) {
        savedTeams = temp.split("__");
      }
    }

    colorTextLeft = colorTextLeft;
    colorBackgroundLeft = colorBackgroundLeft;
    colorTextRight = colorTextRight;
    colorBackgroundRight = colorBackgroundRight;

    pendingColorTextLeft = colorTextLeft;
    pendingColorBackgroundLeft = colorBackgroundLeft;
    pendingColorTextRight = colorTextRight;
    pendingColorBackgroundRight = colorBackgroundRight;
  }

  //
  // Public methods
  //

  int parseReflectorHex(String part) {
    int result = int.parse(part, radix: 16);
    return result;
  }

  int parseReflectorInt(String part) {
    int result = int.parse(part, radix: 10);
    return result;
  }

  String parseLastRefelector(String last) {
    if (last.isEmpty) {
      return "";
    }

    int temp = 0;
    String result = "";
    List<String> parts = last.split(",");

    // time keeper colorA1 colorA2 colorB1 colorB2 nameA nameB setsA setsB scoreA scoreB possesion font zoom     sets5    setsShow
    // 0    1      2       3       4       5       6     7     8     9     10     11     12        13   14       15       16
    //                                                                                   1|2       str  zoomOn|  sets5|   setsShowOn|
    //                                                                                                  zoomOff  sets3    setsShowOff
    if (parts.length >= 17) {
      // workaround for back colors, need to debug
      temp = parseReflectorHex(parts[2]);
      if ((temp & 0xff000000) == 0) {
        print("BAD colors!!!");
        print(last);
      } else {
        colorTextLeft = Color(parseReflectorHex(parts[2]));
        colorBackgroundLeft = Color(parseReflectorHex(parts[3]));
        colorTextRight = Color(parseReflectorHex(parts[4]));
        colorBackgroundRight = Color(parseReflectorHex(parts[5]));
      }

      labelLeft = parts[6];
      labelRight = parts[7];

      setsLeft = parseReflectorInt(parts[8]);
      setsRight = parseReflectorInt(parts[9]);

      valueLeft = parseReflectorInt(parts[10]);
      valueRight = parseReflectorInt(parts[11]);

      lastPointLeft = parseReflectorInt(parts[12]) == 1;

      fontType = stringToFont(parts[13]);
      zoom = (parts[14] == "zoomOn");
      sets5 = (parts[15] == "sets5");
      setsShow = (parts[16] == "setsShowOn");
    }
    // time keeper comment
    // 0    1      2
    if (parts.length == 3) {
      result = parts[2];
    }

    return result;
  }

  String getLabelLeft() {
    String result = labelLeft;
    if (lastPointEnabled) {
      if ((valueLeft > 0 || valueRight > 0) && lastPointLeft) {
        result = labelLeft + " >";
      }
    }
    return result;
  }

  String getLabelRight() {
    String result = labelRight;
    if (lastPointEnabled) {
      if ((valueLeft > 0 || valueRight > 0) && !lastPointLeft) {
        result = "< " + labelRight;
      }
    }
    return result;
  }

  void incrementLeft() {
    valueLeft += 1;
    lastPointLeft = true;
  }

  void decrementLeft() {
    valueLeft -= 1;
    if (valueLeft < 0) valueLeft = 0;
  }

  void incrementRight() {
    valueRight += 1;
    lastPointLeft = false;
  }

  void decrementRight() {
    valueRight -= 1;
    if (valueRight < 0) valueRight = 0;
  }

  void clearBoth() {
    valueLeft = 0;
    valueRight = 0;
    lastPointLeft = false;
  }

  void resetBoth() {
    labelLeft = "Away";
    labelRight = "Home";
    valueLeft = 0;
    valueRight = 0;
    lastPointLeft = false;
    colorTextLeft = Colors.black;
    colorBackgroundLeft = Colors.red;
    colorTextRight = Colors.black;
    colorBackgroundRight = Colors.blueAccent;
    pendingColorTextLeft = colorTextLeft;
    pendingColorBackgroundLeft = colorBackgroundLeft;
    pendingColorTextRight = colorTextRight;
    pendingColorBackgroundRight = colorBackgroundRight;
    fontType = FontTypes.system;
    setsLeft = 0;
    setsRight = 0;
  }

  void swapTeams() {
    var valueTemp = valueLeft;
    valueLeft = valueRight;
    valueRight = valueTemp;
    lastPointLeft = !lastPointLeft;

    var labelTemp = labelLeft;
    labelLeft = labelRight;
    labelRight = labelTemp;

    var colorTemp = colorTextLeft;
    colorTextLeft = colorTextRight;
    colorTextRight = colorTemp;

    colorTemp = colorBackgroundLeft;
    colorBackgroundLeft = colorBackgroundRight;
    colorBackgroundRight = colorTemp;

    var setsTemp = setsLeft;
    setsLeft = setsRight;
    setsRight = setsTemp;
  }

  void addSavedTeam(String label, String color1, String color2) {
    var teamString = "";
    teamString += label;
    teamString += ",";
    teamString += color1.replaceAll(")", "").split("0x")[1];
    teamString += ",";
    teamString += color2.replaceAll(")", "").split("0x")[1];
    if (!savedTeams.contains(teamString)) {
      if (savedTeams.length >= 10) {
        savedTeams.removeAt(savedTeams.length - 1);
      }
      savedTeams.insert(0, teamString);
    }
  }

  void savePending() {
    labelLeft = pendingLabelLeft;
    labelRight = pendingLabelRight;
    colorTextLeft = pendingColorTextLeft;
    colorBackgroundLeft = pendingColorBackgroundLeft;
    colorTextRight = pendingColorTextRight;
    colorBackgroundRight = pendingColorBackgroundRight;

    addSavedTeam(
      labelLeft,
      colorTextLeft.toString(),
      colorBackgroundLeft.toString(),
    );
    addSavedTeam(
      labelRight,
      colorTextRight.toString(),
      colorBackgroundRight.toString(),
    );
  }

  void setPending() {
    pendingLabelLeft = labelLeft;
    pendingLabelRight = labelRight;
    pendingColorTextLeft = colorTextLeft;
    pendingColorTextRight = colorTextRight;
    pendingColorBackgroundLeft = pendingColorBackgroundLeft;
    pendingColorBackgroundRight = pendingColorBackgroundRight;
  }

  void setPendingSavedTeam(String teamString, String side) {
    var parts = teamString.split(",");
    if (side == "left") {
      pendingLabelLeft = parts[0];
      pendingColorTextLeft = stringToColor("Color(0x" + parts[1] + ")");
      pendingColorBackgroundLeft = stringToColor("Color(0x" + parts[2] + ")");
    }
    if (side == "right") {
      pendingLabelRight = parts[0];
      pendingColorTextRight = stringToColor("Color(0x" + parts[1] + ")");
      pendingColorBackgroundRight = stringToColor("Color(0x" + parts[2] + ")");
    }
  }

  bool notify7() {
    if (notify7Enabled) {
      if (((valueLeft + valueRight) % 7) == 0) return true;
    }
    return false;
  }

  bool notify8() {
    if (notify8Enabled) {
      if (valueLeft == 8 || valueRight == 8) return true;
    }
    return false;
  }
}
