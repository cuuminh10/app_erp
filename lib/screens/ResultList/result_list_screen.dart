import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/screens/ResultList/component/body.dart';

class ResultListScreen extends StatefulWidget {

  final dynamic infoScreen;
  const ResultListScreen ({ Key? key, required this.infoScreen }): super(key: key);

  @override
  _ResultListScreen createState() => _ResultListScreen();
}

class _ResultListScreen extends State<ResultListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(infoScreen: this.widget.infoScreen,)
    );
  }
}
