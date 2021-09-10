import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class FancyFab extends StatefulWidget {

  final void Function()  onScan;

  const FancyFab({
    Key? key,
    required this.onScan,
  }) : super(key: key);
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
   Animation<Color?>? _buttonColor;
    Animation<double>? _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: HexColor(kOrange600),
      end: HexColor(kOrange600),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget scan() {
    return Container(
      child: FloatingActionButton(
        backgroundColor:  HexColor(kOrange600),
        onPressed: () => {this.widget.onScan()},
        tooltip: 'Add',
        child: SvgPicture.asset(
          "assets/images/Scan.svg",
          color: Colors.white,
        ),
      ),
    );
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        backgroundColor:  HexColor(kOrange600),
        onPressed: null,
        tooltip: 'Inbox',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor!.value,
        onPressed: animate,
        child:isOpened ? AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon!,
        ) :  SvgPicture.asset(
          "assets/images/Paper.svg",
          width: 30,
          height: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: scan(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: add(),
        ),
        toggle(),
      ],
    );
  }
}