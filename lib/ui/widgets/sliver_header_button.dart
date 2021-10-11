import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverHeaderButton extends StatelessWidget {
  final Function? onPressed;
  final String? text;
  final double? height;
  final double? width;
  final Icon? icon;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final BorderSide? border;

  SliverHeaderButton(
      {required this.onPressed,
      this.text,
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
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton(
          style: ButtonStyle(
              shadowColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) =>
                      Theme.of(context).accentColor.withOpacity(1)),
              elevation: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) => 3.0),
              backgroundColor: MaterialStateProperty.all(
                  color ?? Theme.of(context).primaryColor),
              visualDensity: VisualDensity.compact,
              shape: MaterialStateProperty.resolveWith((states) =>
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(3))))),
          child: Container(
            width: width ?? null,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? Container(),
                icon != null && text != null
                    ? const SizedBox(width: 12)
                    : Container(),
                text != null
                    ? Text(text!,
                        style:
                            textStyle ?? Theme.of(context).textTheme.bodyText2)
                    : Container(),
              ],
            ),
          ),
          onPressed: () {
            onPressed!();
          }),
    );
  }
}
