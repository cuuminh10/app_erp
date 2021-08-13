import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/screens/JobTickets/component/body.dart';

class JobTicketScreen extends StatefulWidget {
  @override
  _JobTicketScreen createState() => _JobTicketScreen();
}

class _JobTicketScreen extends State<JobTicketScreen> {
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
