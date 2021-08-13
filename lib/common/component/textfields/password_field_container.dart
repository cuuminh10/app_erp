import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class PasswordTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Set<void> Function() onPress;
  final bool hidePassword;
  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.onPress,
    required this.hidePassword,
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
        obscureText: hidePassword,
        cursorColor: kCurso01,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hintText,
          suffixIcon:  IconButton(icon: Icon(hidePassword ? Icons.visibility_outlined  : Icons.visibility_off_outlined , color: HexColor(kInvisible),),
            onPressed: onPress,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
