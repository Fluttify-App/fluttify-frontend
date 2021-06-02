import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FluttifyButton extends StatelessWidget {
  Function? onPressed;
  String? text;
  double? height;
  double? width;
  Color? color;
  TextStyle? textStyle;

  FluttifyButton(
      {required this.onPressed,
      required this.text,
      this.height,
      this.width,
      this.color,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: SizedBox(
          height: height ?? MediaQuery.of(context).size.width / 2 - 150,
          width: width ?? MediaQuery.of(context).size.width - 100,
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: color ?? Theme.of(context).accentColor,
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              child: Text(text!, style: textStyle ?? Theme.of(context).textTheme.button),
              onPressed: onPressed as void Function()?),
        ),
      ),
    );
  }
}
