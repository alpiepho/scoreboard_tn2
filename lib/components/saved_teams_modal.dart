import 'package:flutter/material.dart';
import '../constants.dart';
import '../engine.dart';

// ignore: must_be_immutable
class SavedTeamsModal extends StatefulWidget {
  late BuildContext context;
  late Engine engine;
  late String side;
  late Function onDone;

  SavedTeamsModal(
    BuildContext context,
    Engine engine,
    String side,
    Function onDone,
  ) {
    this.context = context;
    this.engine = engine;
    this.side = side;
    this.onDone = onDone;
  }

  @override
  _SavedTeamsModal createState() => _SavedTeamsModal(
        context,
        engine,
        side,
        onDone,
      );
}

class _SavedTeamsModal extends State<SavedTeamsModal> {
  _SavedTeamsModal(
    BuildContext context,
    Engine engine,
    String side,
    Function onDone,
  ) {
    this.context = context;
    this.engine = engine;
    this.side = side;
    this.onDone = onDone;
  }

  late BuildContext context;
  late Engine engine;
  late String side;
  late Function onDone;

  String buildTeamString() {
    var result = "";
    if (side == "left") {
      result += engine.labelLeft;
      result += ",";
      result +=
          engine.colorTextLeft.toString().replaceAll(")", "").split("0x")[1];
      result += ",";
      result += engine.colorBackgroundLeft
          .toString()
          .replaceAll(")", "")
          .split("0x")[1];
    }
    if (side == "right") {
      result += engine.labelRight;
      result += ",";
      result +=
          engine.colorTextRight.toString().replaceAll(")", "").split("0x")[1];
      result += ",";
      result += engine.colorBackgroundRight
          .toString()
          .replaceAll(")", "")
          .split("0x")[1];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var current = buildTeamString();
    var checked = !engine.savedTeams.contains(current);
    List<Widget> teamTiles = [];
    teamTiles.add(
      new ListTile(
          title: new Text(
            "None",
            style: kSettingsTextEditStyle,
          ),
          trailing: new Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
          ),
          onTap: () {
            onDone();
          }),
    );
    for (var teamString in engine.savedTeams) {
      var checked = current == teamString;
      var parts = teamString.split(",");
      var teamName = parts[0];
      var teamColor = engine.stringToColor("Color(0x" + parts[1] + ")");
      var teamBackgroundColor =
          engine.stringToColor("Color(0x" + parts[2] + ")");
      teamTiles.add(
        new ListTile(
            title: new Text(
              teamName,
              style: kSettingsTextEditStyle.copyWith(
                color: teamColor,
                backgroundColor: teamBackgroundColor,
              ),
            ),
            trailing: new Icon(
              checked ? Icons.check_box : Icons.check_box_outline_blank,
            ),
            onTap: () {
              engine.setPendingSavedTeam(teamString, side);
              onDone();
            }),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        titleSpacing: 20,
        title: Text(
          "Saved Teams",
          style: kSettingsTextEditStyle,
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            SettingsDivider(),
            ...teamTiles,
            SettingsDivider(),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 2,
    );
  }
}
