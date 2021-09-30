import 'package:flutter/material.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/screens/ImageFullScreen/component/body.dart';

class ImageFullScreen extends StatefulWidget {

  final Comment comment;
  final dynamic infoScreen;

  const ImageFullScreen ({ Key key,  this.comment, this.infoScreen }): super(key: key);

  @override
  _ImageFullScreen createState() => _ImageFullScreen();
}

class _ImageFullScreen extends State<ImageFullScreen> {
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
