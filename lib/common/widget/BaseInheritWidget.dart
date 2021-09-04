import 'package:flutter/cupertino.dart';

class BaseInheritedWidget extends InheritedWidget {

  BaseInheritedWidget({required Widget child,  this.myData, this.state, this.infoScreen}) : super(child: child);

  final dynamic myData;
  final state;
  final dynamic infoScreen;

  @override
  bool updateShouldNotify(BaseInheritedWidget oldWidget) {
    return myData != oldWidget.myData;
  }

  static BaseInheritedWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<BaseInheritedWidget>();
  }
}