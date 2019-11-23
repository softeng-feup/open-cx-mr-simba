import 'package:flutter/material.dart';
import '../../constants/AppColors.dart' as AppColors;

class GenericTitle extends StatelessWidget {
  GenericTitle({this.title, this.style, this.padding, this.margin});

  final String title;
  final TextStyle style;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: this.padding,
        margin: this.margin,
        decoration: new BoxDecoration(
            color: AppColors.containerColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(this.title, style: this.style));
  }
}
