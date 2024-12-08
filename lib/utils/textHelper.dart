import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextHelper extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontsize;
  final bool isfontWeightBold;
  final String fontFamily;
  final bool isOverflow;
  final bool isUnderline;
  final FontWeight fontWeight;
  final TextAlign align;
  TextHelper(
      {super.key,
      this.fontsize = 20,
      this.isfontWeightBold = false,
      this.textColor = Colors.black,
      this.fontFamily = 'vietnam',
      this.isOverflow = false,
      this.isUnderline = false,
      this.fontWeight = FontWeight.w600,
      this.align = TextAlign.start,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TextStyle(
        color: textColor,
        fontSize: fontsize,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        fontWeight: isfontWeightBold ? FontWeight.w900 : fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
