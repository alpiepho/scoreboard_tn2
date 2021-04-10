import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  SettingsButton({this.onPress});

  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        onPressed:  onPress as void Function()?,
        tooltip: 'Settings',
        child: Icon(Icons.settings, size: 50),
      ),
    );
  }
}
