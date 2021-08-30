import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/screens/JobDetail/component/body.dart';

class JobDetailScreen extends StatefulWidget {
  final ProductOrderDetail productOrderDetail;

  const JobDetailScreen ({ Key? key, required this.productOrderDetail }): super(key: key);

  @override
  _JobDetailScreen createState() => _JobDetailScreen();
}

class _JobDetailScreen extends State<JobDetailScreen> {
  int counter = 0;

  changePageIndex(int newIndex) {
    setState(() {
      counter = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseInheritedWidget(myData: counter, child: Body(productOrderDetail: this.widget.productOrderDetail,), state: this,),
    );
  }
}
