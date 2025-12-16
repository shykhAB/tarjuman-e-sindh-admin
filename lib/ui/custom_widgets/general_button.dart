import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class GeneralButton extends StatelessWidget {

  final String text;
  final Color textColor;
  final void Function() onPressed;
  final double marginHorizontal;
  final double marginVertical;
  final Color color;
  final Color? secondColor;
  final double fontSize;
  final double radius;
  final double width;
  final double height;
  final BorderSide borderSide;
  final dynamic icon;
  final double iconSize;

  const GeneralButton({super.key,this.borderSide=BorderSide.none, required this.onPressed, this.text='Submit',this.textColor=kWhiteColor, this.marginHorizontal=0, this.marginVertical=0, this.color=kCardShadowColor, this.fontSize = 18.0, this.radius = 25, this.width = 500, this.height = 44, this.icon, this.iconSize = 19, this.secondColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            colors: [color, secondColor??kPrimaryDarkColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
        ),
        margin: EdgeInsets.symmetric(horizontal: marginHorizontal, vertical: marginVertical),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: icon != null ? MainAxisAlignment.center : MainAxisAlignment.center ,
            children: [
              if(icon != null)
                icon is String? Image.asset("assets/icons/$icon.png", height: iconSize,): Icon(icon, size: iconSize, color: kWhiteColor,),
              Text(" $text",
                style: TextStyle(
                    fontSize: fontSize,
                    color:textColor,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
