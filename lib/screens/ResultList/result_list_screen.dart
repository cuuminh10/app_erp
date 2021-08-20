import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/screens/ResultList/component/body.dart';

class ResultListScreen extends StatefulWidget {
  @override
  _ResultListScreen createState() => _ResultListScreen();
}

class _ResultListScreen extends State<ResultListScreen> {
  int counter = 0;

  changePageIndex(int newIndex) {
    setState(() {
      counter = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseInheritedWidget(myData: counter, child: Body(), state: this,),
    );
  }
}
