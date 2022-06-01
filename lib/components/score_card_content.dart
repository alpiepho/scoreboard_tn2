import 'package:flutter/material.dart';

class TeamScoreCardContent extends StatelessWidget {
  const TeamScoreCardContent({
    Key? key,
    required this.label,
    required this.textStyle,
    required this.colorText,
    required this.value,
    required this.numberTextStyle,
    required this.zoom,
    required this.setsShow,
    required this.sets5,
    required this.sets,
  }) : super(key: key);

  final String label;
  final TextStyle textStyle;
  final Color colorText;
  final int value;
  final TextStyle numberTextStyle;
  final bool zoom;
  final bool setsShow;
  final bool sets5;
  final int sets;

  @override
  Widget build(BuildContext context) {
    var text = zoom
        ? SizedBox.shrink()
        : Text(
            label,
            style: textStyle.copyWith(color: colorText),
          );
    var indicators = [];
    if (setsShow) {
      indicators.clear();
      var maxSets = sets5 ? 5 : 3;
      for (int i = 0; i < maxSets; i++) {
        Widget nextSet = SetIndicator(colorText: colorText, filled: (sets > i));
        indicators.add(nextSet);
      }
    } else {
      indicators.add(SizedBox.shrink());
    }

    // RepaintBoundary should help perfromance since score changes are most active
    return RepaintBoundary(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          text,
          Transform.scale(
            scale: zoom ? 1.5 : 1.0,
            child: Text(
              (value).toString(),
              style: numberTextStyle.copyWith(color: colorText),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [...indicators],
          ),
        ],
      ),
    );
  }
}

class SetIndicator extends StatelessWidget {
  const SetIndicator({
    Key? key,
    required this.colorText,
    required this.filled,
  }) : super(key: key);

  final Color colorText;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: filled ? colorText : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: colorText)),
    );
  }
}
