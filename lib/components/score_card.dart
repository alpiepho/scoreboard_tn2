import 'package:flutter/material.dart';

class TeamScoreCard extends StatelessWidget {
  TeamScoreCard(
      {required this.color,
      required this.margin,
      this.cardChild,
      this.onPress,
      this.onPan});

  final Color color;
  final EdgeInsets margin;
  final Widget? cardChild;
  final Function? onPress;
  final Function? onPan;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (portrait) {
      height = height / 2;
    } else {
      width = width / 2;
    }

    //DEBUG
    //width = width * 0.5;
    //height = height * 0.5;

    return GestureDetector(
      onTap: onPress as void Function()?,
      onPanUpdate: onPan as void Function(DragUpdateDetails)?,
      child: Container(
        color: color,
        child: cardChild,
        margin: margin,
        width: width,
        height: height,
      ),
    );
  }
}
