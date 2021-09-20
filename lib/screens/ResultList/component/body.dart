import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/buttons/fancy.dart';
import 'package:gmc_erp/common/component/list_card/List_card_badge.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/screens/JobDetail/job_detail_screen.dart';
import 'package:gmc_erp/screens/ResultList/component/background.dart';
import 'package:gmc_erp/states/product_order_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class Body extends StatefulWidget {
  final dynamic infoScreen;

  const Body({
    Key key,
     this.infoScreen,
  }) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String data = '';
  ProductOrderBloc _productOrderBloc;
  ProductOrderCount productOrderCount;

  @override
  void initState() {
    super.initState();
    _productOrderBloc = BlocProvider.of(context);
    _productOrderBloc.add(getCountEvent(type: this.widget.infoScreen['code']));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onHandleClickItem(String no) {
    _productOrderBloc.add(
        getPoOrderDetailEvent(type: this.widget.infoScreen['code'], no: no));
  }

  void scan() async => {
        await FlutterBarcodeScanner.scanBarcode(
                "#ff6666", "Cancel", false, ScanMode.DEFAULT)
            .then((barcode) {
          onHandleClickItem(barcode);
        })
      };

  void scanCreate() async => {
        await FlutterBarcodeScanner.scanBarcode(
                "#ff6666", "Cancel", false, ScanMode.DEFAULT)
            .then((barcode) {
          _productOrderBloc.add(getNewPrScanEvent(no: barcode));
        })
      };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(this.widget.infoScreen['name']),
          actions: <Widget>[
            IconButton(
                icon: SvgPicture.asset(
                  "assets/images/Scan.svg",
                ),
                onPressed: () => scan()),
            IconButton(
                icon: SvgPicture.asset(
                  "assets/images/Filter.svg",
                ),
                onPressed: () => {
                      this.setState(() {
                        data = 'vao123';
                      })
                    } //do something,
                ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocConsumer<ProductOrderBloc, ProductOrderState>(
              listener: (context, state) {
            if (state is ProductOrderCountSuccess) {
              setState(() {
                productOrderCount = state.productOrderCount;
              });
            }

            if (state is ProductOrderDetailSuccess) {
              print('12333333');
            }

            if (state is ProductOrderCreateFailer) {
              // set up the AlertDialog

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Error"),
                content: Text(
                    "Phiếu không có chi tiết hoặc đã ra hết số lượng!"),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }

            if (state is ProductOrderCreateSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return JobDetailScreen(
                    productOrderDetail: state.productOrderDetail,
                    isNewProduct: true,
                  );
                }),
              );
            }

            if (state is ProductOrderCreateSuccess) {}
          }, builder: (context, state) {
            if (state is ProductOrderCountSuccess) {
              return GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 5 / 1,
                children: [
                  ListCardBadge(
                      tittle: 'Open',
                      code: this.widget.infoScreen['code'],
                      count: state.productOrderCount.opens,
                      onTap: (e) => {onHandleClickItem(e)}),
                  ListCardBadge(
                      tittle: 'Overdue',
                      code: this.widget.infoScreen['code'],
                      count: state.productOrderCount.overdue,
                      onTap: (e) => {onHandleClickItem(e)}),
                  ListCardBadge(
                      tittle: 'Incomplete',
                      code: this.widget.infoScreen['code'],
                      count: state.productOrderCount.incompleted,
                      onTap: (e) => {onHandleClickItem(e)}),
                  ListCardBadge(
                      tittle: 'Complete',
                      code: this.widget.infoScreen['code'],
                      count: state.productOrderCount.completed,
                      onTap: (e) => {onHandleClickItem(e)}),
                ],
              );
            } else {
              if (productOrderCount != null) {
                return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 5 / 1,
                  children: [
                    ListCardBadge(
                        tittle: 'Open',
                        code: this.widget.infoScreen['code'],
                        count: productOrderCount.opens,
                        onTap: (e) => {onHandleClickItem(e)}),
                    ListCardBadge(
                        tittle: 'Overdue',
                        code: this.widget.infoScreen['code'],
                        count: productOrderCount.overdue,
                        onTap: (e) => {onHandleClickItem(e)}),
                    ListCardBadge(
                        tittle: 'Incomplete',
                        code: this.widget.infoScreen['code'],
                        count: productOrderCount.incompleted,
                        onTap: (e) => {onHandleClickItem(e)}),
                    ListCardBadge(
                        tittle: 'Complete',
                        code: this.widget.infoScreen['code'],
                        count: productOrderCount.completed,
                        onTap: (e) => {onHandleClickItem(e)}),
                  ],
                );
              } else {
                return Container(child: Text('123123'));
              }
            }
          }),
        ),
        floatingActionButton: FancyFab(onScan: () => scanCreate()),
      ),
    );
  }
}
