import 'package:flutter/material.dart';

class TeamScoreCard extends StatelessWidget {
  TeamScoreCard({required this.color, required this.margin, required this.portrait, this.cardChild, this.onPress, this.onPan});

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
        onTapUp: onPress as void Function(TapUpDetails)?,
        onPanUpdate: onPan as void Function(DragUpdateDetails)?,
        child: Container(
          child: cardChild,
          margin: margin,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            //borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
