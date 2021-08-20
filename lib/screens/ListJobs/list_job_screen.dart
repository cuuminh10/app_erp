import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/screens/ListJobs/component/body.dart';

class ListJobsScreen extends StatefulWidget {
  final String tittle;

  const ListJobsScreen ({ Key? key, required this.tittle }): super(key: key);


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
    return Scaffold(
      body: BaseInheritedWidget(myData: counter, child: Body(tittle: this.widget.tittle,), state: this,),
    );
  }
}
