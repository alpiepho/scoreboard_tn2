import 'package:flutter/material.dart';

class TeamScoreCard extends StatelessWidget {
  TeamScoreCard({required this.color, this.cardChild, this.onPress, this.onPan});

  final Color color;
  final Widget? cardChild;
  final Function? onPress;
  final Function? onPan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress as void Function()?,
      onPanUpdate: onPan as void Function(DragUpdateDetails)?,
      child: Container(
        child: cardChild,
        //margin: EdgeInsets.all(10.0),
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          //borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
