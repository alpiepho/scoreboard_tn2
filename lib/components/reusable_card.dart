import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.color, this.cardChild, this.onPress, this.onDragStart, this.onDragEnd});

  final Color color;
  final Widget? cardChild;
  final Function? onPress;
  final Function? onDragStart;
  final Function? onDragEnd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress as void Function()?,
      onVerticalDragStart: onDragStart as void Function(DragStartDetails)?,
      onVerticalDragEnd: onDragEnd as void Function(DragEndDetails)?,
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
