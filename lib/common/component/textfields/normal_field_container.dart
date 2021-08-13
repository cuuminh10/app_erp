import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class NormalTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const NormalTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: HexColor(kNornalTextFieldColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: kCurso01,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          labelText: hintText,
        ),
      ),
    );
  }
}
