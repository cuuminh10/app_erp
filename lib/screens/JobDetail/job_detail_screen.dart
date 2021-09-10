import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/screens/JobDetail/component/body.dart';

class JobDetailScreen extends StatefulWidget {
  final ProductOrderDetail productOrderDetail;
  final bool? isNewProduct;

  const JobDetailScreen ({ Key? key, required this.productOrderDetail, this.isNewProduct = false }): super(key: key);

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
      body:  Body(productOrderDetail: this.widget.productOrderDetail, isNewProduct:  this.widget.isNewProduct!)
    );
  }
}
