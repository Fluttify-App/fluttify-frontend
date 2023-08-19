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
  final EdgeInsets? padding;
  final BorderSide? border;

  FluttifyButton(
      {required this.onPressed,
      required this.text,
      this.height,
      this.width,
      this.icon,
      this.color,
      this.textStyle,
      this.padding,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        child: Container(
          height: height ?? 40,
          width: width ?? null,
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: color ?? Theme.of(context).primaryColor,
                  //shape: StadiumBorder(
                  //  side: BorderSide(color: Colors.transparent),
                  //),
                  shape: border != null
                      ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: border!)
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
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
                              style: textStyle ??
                                  Theme.of(context).textTheme.button),
                        )
                      ],
                    ),
              onPressed: onPressed as void Function()?),
        ),
      ),
    );
  }
}
