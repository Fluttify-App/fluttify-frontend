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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            /*  side: MaterialStateProperty.resolveWith<BorderSide?>(
                  (Set<MaterialState> states) => BorderSide(
                      width: 0, color: Theme.of(context).accentColor)
                      ) */
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? Container(),
              icon != null ? const SizedBox(width: 12) : Container(),
              Text(text!,
                  style: textStyle ?? Theme.of(context).textTheme.bodyText2),
            ],
          ),
          onPressed: () {
            onPressed!();
          }),
    );
    return Padding(
      padding: padding ?? const EdgeInsets.all(10),
      child: Container(
        child: SizedBox(
          height: height ?? 45,
          width: width ?? MediaQuery.of(context).size.width - 100,
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
