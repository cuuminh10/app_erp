import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
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
  PDFDocument document;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadPdf() async {
    setState(() {
      _isLoading = true;
    });
    document = await PDFDocument.fromURL('http://175.41.183.152:8080/fc/viewFile/${this.widget.infoScreen["code"]}/${this.widget.comment.saveName}');
    setState(() {
      _isLoading = false;
    });
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
          body: Center(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : PDFViewer(document: document)),
    ));
  }
}
