/**
 * Copyright (C) 2021
 *
 * Description: The file class
 *
 * Change history:
 * Date             Defect#             Person             Comments
 * -------------------------------------------------------------------------------
 * August 4, 2021     ********           HoangNCM            Initialize
 *
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_border/dotted_border.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final Set<void> Function() onPress;
  final double vertical;
  final double horizontal;
  final double width;
  final HexColor? color;
  const NormalButton({
    Key? key,
    required this.text,
    required this.onPress,
    required this.vertical,
    required this.horizontal,
    required this.width,
    this.color
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
          color: this.color != null ? color : HexColor(kLogin),
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
