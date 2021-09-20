import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/file_comment_bloc.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/buttons/gmc_button_container.dart';
import 'package:gmc_erp/common/component/comment/CommenBox.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/events/file_comment_event.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/states/file_comment_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/screens/ListJobs/component/background.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/public/ultis/convert_date.dart';
import 'package:gmc_erp/public/ultis/ultis.dart';
import 'package:gmc_erp/common/component/buttons/gmc_button_dotted.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  final Detail detail;
  final String no;

  const Body(this.detail, this.no, {Key key}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final TextEditingController _nameTextFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameTextFieldController.value = TextEditingValue(
        text: 'item ' + this.widget.detail.productNo.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(this.widget.no),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context, true)}),
        actions: <Widget>[
          IconButton(
              icon: SvgPicture.asset(
                "assets/images/dot.svg",
              ),
              onPressed: () => {} //do something,
              ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              style: TextStyle(color: HexColor(kBlue500)),
              controller: _nameTextFieldController,
              showCursor: false,
              readOnly: true,
              decoration: InputDecoration(
                enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: HexColor(kBlue100))),
                labelStyle: TextStyle(
                    color: HexColor(kBlue800), fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: size.width * 0.05),
            Text(
              'Phase ' + this.widget.detail.phaseName.toString(),
              style: TextStyle(color: HexColor(kBlue500), fontSize: 16.0),
            ),
            SizedBox(height: size.width * 0.05),
            Text(
              'Detail',
              style: TextStyle(
                  color: HexColor(kBlue500),
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.width * 0.03),
            Table(
              columnWidths: {
                0: FlexColumnWidth(5),
                1: IntrinsicColumnWidth(),
                2: FlexColumnWidth(1),
                3: IntrinsicColumnWidth(),
              },
              // defaultColumnWidth: IntrinsicColumnWidth(),
              // border: TableBorder.all(
              //     width: 1.0, color: HexColor(kBlue500)),
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: [
                TableRow(
                    decoration: BoxDecoration(color: HexColor(kBlue100)),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Finish Qty',
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: this.widget.detail.qty != 0
                                  ? () => {
                                        setState(() {
                                          this.widget.detail.qty--;
                                        })
                                      }
                                  : null,
                              child: Text(
                                '-',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            this.widget.detail.qty.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: () => {
                                setState(() {
                                  this.widget.detail.qty++;
                                })
                              },
                              child: Text(
                                '+',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                TableRow(
                    decoration: BoxDecoration(color: HexColor(kBlue100)),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Set up Qty',
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: this.widget.detail.setUpQty != 0
                                  ? () => {
                                        setState(() {
                                          this.widget.detail.setUpQty--;
                                        })
                                      }
                                  : null,
                              child: Text(
                                '-',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            this.widget.detail.setUpQty.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: () => {  setState(() {
                                this.widget.detail.setUpQty++;
                              })},
                              child: Text(
                                '+',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                TableRow(
                    decoration: BoxDecoration(color: HexColor(kBlue100)),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'NCR Qty',
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: this.widget.detail.ncrQty != 0
                                  ? () => {  setState(() {
                                this.widget.detail.ncrQty--;
                              })}
                                  : null,
                              child: Text(
                                '-',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            this.widget.detail.ncrQty.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: () => {setState(() {
                                this.widget.detail.ncrQty++;
                              })},
                              child: Text(
                                '+',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                TableRow(
                    decoration: BoxDecoration(color: HexColor(kBlue100)),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel Qty',
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: this.widget.detail.cancelQty != 0
                                  ? () => {setState(() {
                                this.widget.detail.cancelQty--;
                              })}
                                  : null,
                              child: Text(
                                '-',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            this.widget.detail.cancelQty.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: HexColor(kBlue800)),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 4.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: HexColor(kBlue500), width: 1.0)),
                            child: FlatButton(
                              color: HexColor(kBlue100),
                              onPressed: () => {setState(() {
                                this.widget.detail.cancelQty++;
                              })},
                              child: Text(
                                '+',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: HexColor(kBlue800),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: NormalButton(
                        text: "Done",
                        onPress: () => {Navigator.pop(context, this.widget.detail)},
                        vertical: 20,
                        horizontal: 40,
                        width: 0.6))),
          ],
        ),
      ),
    ));
  }
}
