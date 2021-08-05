import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class ServerTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Set<void> Function() onPress;
  const ServerTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.onPress,
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
        showCursor: false,
        readOnly: true,
        onChanged: onChanged,
        cursorColor: kCurso01,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon:  IconButton(icon: Icon(Icons.keyboard_arrow_down, color: HexColor(kInvisible),),
            onPressed: onPress,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
