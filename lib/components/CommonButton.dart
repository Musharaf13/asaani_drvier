// import 'package:asaani/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonButtom extends StatelessWidget {
  const CommonButtom({
    @required this.title,
    @required this.color,
    @required this.onpress,
    this.width,
  });

  final String title;
  final Color color;
  final Function onpress;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width : 300,
      child: FlatButton(
        onPressed: onpress,
        splashColor: Colors.lightBlue[100],
        // highlightColor: Colors.white,
        child: Text(title),
        color: color,
        shape: RoundedRectangleBorder(
          // side: BorderSide(width: 1.5, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
