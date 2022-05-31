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
  }) : super(key: key);

  final String label;
  final TextStyle textStyle;
  final Color colorText;
  final int value;
  final TextStyle numberTextStyle;
  final bool zoom;

  @override
  Widget build(BuildContext context) {
    var text = zoom
        ? SizedBox.shrink()
        : Text(
            label,
            style: textStyle.copyWith(color: colorText),
          );
    // TODO: not sure if RepaintBoundary helps
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
        ],
      ),
    );
  }
}
