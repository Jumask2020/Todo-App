

import 'package:flutter/material.dart';

class CostumText extends StatelessWidget {
  const CostumText({super.key,required this.text, this.fontSize, this.color});
  final String text;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize:fontSize??20,fontWeight: FontWeight.bold,color:color??Colors.black ),
    );
  }
}
