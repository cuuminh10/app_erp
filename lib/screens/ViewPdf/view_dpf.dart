import 'package:flutter/material.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/screens/ViewPdf/component/body.dart';

class ViewPDF extends StatefulWidget {

  final Comment comment;
  final dynamic infoScreen;

  const ViewPDF ({ Key key,  this.comment, this.infoScreen }): super(key: key);

  @override
  _ViewPDF createState() => _ViewPDF();
}

class _ViewPDF extends State<ViewPDF> {
  int counter = 0;

  changePageIndex(int newIndex) {
    setState(() {
      counter = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(comment: this.widget.comment, infoScreen: this.widget.infoScreen,)
    );
  }
}
