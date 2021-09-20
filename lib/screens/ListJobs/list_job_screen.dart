import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/screens/ListJobs/component/body.dart';

class ListJobsScreen extends StatefulWidget {
  final String tittle;

  const ListJobsScreen (this.tittle ,{ Key key }): super(key: key);


  @override
  _ListJobsScreen createState() => _ListJobsScreen();
}

class _ListJobsScreen extends State<ListJobsScreen> {
  int counter = 0;

  changePageIndex(int newIndex) {
    setState(() {
      counter = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final  wrapper = BaseInheritedWidget.of(context);
    return Scaffold(
      body:  Body(tittle: this.widget.tittle)
    );
  }
}
