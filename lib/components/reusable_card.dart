import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.color, this.cardChild, this.onPress, this.onPan});

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
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
