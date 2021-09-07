import 'package:flutter/material.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/screens/RemarkDetail/component/body.dart';

class RemarkDetailScreen extends StatefulWidget {

  final Detail detail;
  final String no;

  const RemarkDetailScreen (this.detail, this.no ,{ Key? key }): super(key: key);

  @override
  _RemarkDetailScreen createState() => _RemarkDetailScreen();
}

class _RemarkDetailScreen extends State<RemarkDetailScreen> {
  int counter = 0;

  changePageIndex(int newIndex) {
    setState(() {
      counter = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Body(this.widget.detail, this.widget.no)
    );
  }
}
