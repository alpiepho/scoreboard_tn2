import 'package:flutter/material.dart';

class TeamScoreCardContent extends StatelessWidget {
  const TeamScoreCardContent({
    Key? key,
    required String label,
    required this.textStyle,
    required Color colorText,
    required int value,
    required this.numberTextStyle,
  })  : _label = label,
        _colorText = colorText,
        _value = value,
        super(key: key);

  final String _label;
  final TextStyle textStyle;
  final Color _colorText;
  final int _value;
  final TextStyle numberTextStyle;

  @override
  Widget build(BuildContext context) {
    // TODO: not sure if RepaintBoundary helps
    return RepaintBoundary(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _label,
            style: textStyle.copyWith(color: _colorText),
          ),
          Text(
            (_value).toString(),
            style: numberTextStyle.copyWith(color: _colorText),
          ),
        ],
      ),
    );
  }
}
