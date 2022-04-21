import 'package:flutter/material.dart';

class TeamScoreCard extends StatelessWidget {
  TeamScoreCard(
      {required this.color,
      required this.margin,
      required this.portrait,
      this.cardChild,
      this.onPress,
      this.onPan});

  final Color color;
  final EdgeInsets margin;
  final bool portrait;
  final Widget? cardChild;
  final Function? onPress;
  final Function? onPan;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: (this.portrait ? 1 : 0),
      child: GestureDetector(
        onTap: onPress as void Function()?,
        onPanUpdate: onPan as void Function(DragUpdateDetails)?,
        child: Container(
          color: color,
          child: cardChild,
          margin: margin,
          width: double.infinity,
        ),
      ),
    );
  }
}
