import 'package:flutter/cupertino.dart';

class BaseInheritedWidget extends InheritedWidget {

  BaseInheritedWidget({required Widget child, required this.myData, required this.state}) : super(child: child);

  final int myData;
  final state;

  @override
  bool updateShouldNotify(BaseInheritedWidget oldWidget) {
    return myData != oldWidget.myData;
  }

  static BaseInheritedWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<BaseInheritedWidget>();
  }
}