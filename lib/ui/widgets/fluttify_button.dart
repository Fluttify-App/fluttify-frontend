import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FluttifyButton extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final double? height;
  final double? width;
  final Icon? icon;
  final Color? color;
  final TextStyle? textStyle;

  FluttifyButton(
      {required this.onPressed,
      required this.text,
      this.height,
      this.width,
      this.icon,
      this.color,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: SizedBox(
          height: height ?? 45,
          width: width ?? MediaQuery.of(context).size.width - 100,
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: color ?? Theme.of(context).accentColor,
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
              child: this.icon == null
                  ? Text(text!,
                      style: textStyle ?? Theme.of(context).textTheme.button)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icon!,
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(text!,
                              style: Theme.of(context).textTheme.button),
                        )
                      ],
                    ),
              onPressed: onPressed as void Function()?),
        ),
      ),
    );
  }
}
