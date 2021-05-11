import 'package:flutter/material.dart';
import 'package:scoreboard_tn/components/score_card.dart';
import 'package:scoreboard_tn/components/settings_button.dart';
import 'package:scoreboard_tn/components/settings_modal.dart';
import 'package:scoreboard_tn/constants.dart';
import 'package:scoreboard_tn/engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey _keyPortraitLeft = GlobalKey();
GlobalKey _keyPortraitRight = GlobalKey();
GlobalKey _keyLandscapeLeft = GlobalKey();
GlobalKey _keyLandscapeRight = GlobalKey();

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
  int _earnedLeft = 0;
  int _earnedRight = 0;
  //bool _earnedEnabled = false;
  bool _earnedVisible = false;

  FontTypes _fontType = FontTypes.system;

  // for increment/decrement swiping
  double _panPositionYLeft = 0.0;
  double _panPositionYRight = 0.0;

  Engine _engine = Engine();

  void _loadEngine() async {
    final prefs = await SharedPreferences.getInstance();
    var packed = prefs.getString('engine') ?? "";
    _engine.unpack(packed);
    _fromEngine();
  }

  void _saveEngine() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('engine', _engine.pack());
  }

  void _fromEngine() async {
    setState(() {
      _labelLeft  = this._engine.labelLeft;
      _labelRight = this._engine.labelRight;
      _valueLeft = this._engine.valueLeft;
      _valueRight = this._engine.valueRight;
      _earnedLeft = this._engine.earnedLeft;
      _earnedRight = this._engine.earnedRight;
      //_earnedEnabled = this._engine.earnedEnabled;
      _earnedVisible = this._engine.earnedVisible;

      _colorTextLeft = this._engine.colorTextLeft;
      _colorBackgroundLeft = this._engine.colorBackgroundLeft;
      _colorTextRight = this._engine.colorTextRight;
      _colorBackgroundRight = this._engine.colorBackgroundRight;

      _fontType = this._engine.fontType;

      _saveEngine();
    });
  }

  bool _hitEarned(TapUpDetails details, BuildContext? c) {
    if (c != null) {
      RenderBox rb = c.findRenderObject() as RenderBox;
      if(rb.size != Size.zero) {
        Offset centerPtInWidgetSpace = Offset(rb.size.width/2, rb.size.height/2);
        Offset centerPtInScreenSpace = rb.localToGlobal(centerPtInWidgetSpace);
        double dx = 1.2*(rb.size.width/2);
        double dy = 1.2*(rb.size.height/2);
        if ((details.globalPosition.dx >= (centerPtInScreenSpace.dx - dx)) &&
            (details.globalPosition.dx <= (centerPtInScreenSpace.dx + dx)) &&
            (details.globalPosition.dy >= (centerPtInScreenSpace.dy - dy)) &&
            (details.globalPosition.dy <= (centerPtInScreenSpace.dy + dy))
        ) {
          return true;
        }
      }
    }
    return false;
  }

  bool _hitEarnedLeft(TapUpDetails details) {
    if (_hitEarned(details, _keyPortraitLeft.currentContext)) {
      return true;
    }
    if (_hitEarned(details, _keyLandscapeLeft.currentContext)) {
      return true;
    }
    return false;
  }

  bool _hitEarnedRight(TapUpDetails details) {
    if (_hitEarned(details, _keyPortraitRight.currentContext)) {
      return true;
    }
    if (_hitEarned(details, _keyLandscapeRight.currentContext)) {
      return true;
    }
    return false;
  }

  void _incrementLeft(TapUpDetails details) async {
    bool earned = _hitEarnedLeft(details);
    this._engine.incrementLeft(earned);
    _fromEngine();
  }

  void _decrementLeft() async {
    this._engine.decrementLeft(true);
    _fromEngine();
  }

  void _incrementRight(TapUpDetails details) async {
    bool earned = _hitEarnedRight(details);
    this._engine.incrementRight(earned);
    _fromEngine();
  }

  void _decrementRight() async {
    this._engine.decrementRight(true);
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
        this._engine.incrementLeft(false);
        _fromEngine();
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
        this._engine.incrementRight(false);
        _fromEngine();
      } else if (_panPositionYRight > 100) {
        _panPositionYRight = 0.0;
        _decrementRight();
      }
    } else {
      _panPositionYRight = 0.0;
    }
  }

  @override
  initState() {
    super.initState();
    _loadEngine();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelTextStyle = kLabelTextStyle_system;
    TextStyle numberTextStyle = kNumberTextStyle_system;

    labelTextStyle = getLabelFont(_fontType);
    numberTextStyle = getNumberFont(_fontType);

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
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelLeft,
                                style: labelTextStyle.copyWith(color: _colorTextLeft),
                              ),
                              Text(
                                (_valueLeft).toString(),
                                style: numberTextStyle.copyWith(color: _colorTextLeft),
                              ),
                              Text(
                                "earned: " + (_earnedLeft).toString(),
                                style: labelTextStyle.copyWith(color: (_earnedVisible ? _colorTextLeft : _colorBackgroundLeft), fontSize: 30),
                                key: _keyPortraitLeft,
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
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelRight,
                                style: labelTextStyle.copyWith(color: _colorTextRight),
                              ),
                              Text(
                                (_valueRight).toString(),
                                style: numberTextStyle.copyWith(color: _colorTextRight),
                              ),
                              Text(
                                "earned: " + (_earnedRight).toString(),
                                style: labelTextStyle.copyWith(color: (_earnedVisible ? _colorTextRight : _colorBackgroundRight), fontSize: 30),
                                key: _keyPortraitRight,
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
                          margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelLeft,
                                style: labelTextStyle.copyWith(color: _colorTextLeft),
                              ),
                              Text(
                                (_valueLeft).toString(),
                                style: numberTextStyle.copyWith(color: _colorTextLeft),
                              ),
                              Text(
                                "earned: " + (_earnedLeft).toString(),
                                style: labelTextStyle.copyWith(color: (_earnedVisible ? _colorTextLeft : _colorBackgroundLeft), fontSize: 30),
                                key: _keyLandscapeLeft,
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
                          margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _labelRight,
                                style: labelTextStyle.copyWith(color: _colorTextRight),
                              ),
                              Text(
                                (_valueRight).toString(),
                                style: numberTextStyle.copyWith(color: _colorTextRight),
                              ),
                              Text(
                                "earned: " + (_earnedRight).toString(),
                                style: labelTextStyle.copyWith(color: (_earnedVisible ? _colorTextRight : _colorBackgroundRight), fontSize: 30),
                                key: _keyLandscapeRight,
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
