import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:hexcolor/hexcolor.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final Set<void> Function() onPress;
  final double vertical;
  final double horizontal;
  final double width;
  const NormalButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.vertical,
    required this.horizontal,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          color: HexColor(kLogin),
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(color: HexColor(kWhite), fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
