import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/screens/DashBoard/component/background.dart';

class Body extends StatefulWidget {
  final Comment comment;
  final dynamic infoScreen;

  const Body({Key key, this.comment, this.infoScreen}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: new Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(this.widget.comment.realName),
      ),
      body: new Image.network(
        "http://175.41.183.152:8080/fc/viewFile/${this.widget.infoScreen["code"]}/${this.widget.comment.saveName}",
        fit: BoxFit.scaleDown,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    ));
  }
}
