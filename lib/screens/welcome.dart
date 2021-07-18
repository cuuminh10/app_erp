import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#07245B'),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage('assets/images/gmc_icon.png'),
                width: 80,
                height: 80),
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 200,
                  margin: const EdgeInsets.only(left: 52.0),
                  child: const Text('GMC',
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
                const Positioned(
                    top: 65,
                    left: 46,
                    child: Text(
                      'EXPERT ERP-SMART SOLUTION',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
