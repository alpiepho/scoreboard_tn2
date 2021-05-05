import 'package:flutter/material.dart';

class TeamScoreCard extends StatelessWidget {
  TeamScoreCard({required this.color, required this.margin, this.cardChild, this.onPress, this.onPan});

  final Color color;
  final EdgeInsets margin;
  final Widget? cardChild;
  final Function? onPress;
  final Function? onPan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
