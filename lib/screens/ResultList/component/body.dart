import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/list_card/List_card_badge.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/states/product_order_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  // String json = '{ "incompleted": 21,  "completed": 26, "opens": 9, "overdue": 12}';
  // ProductOrductCount entries = new ProductOrductCount.fromJsonMap(map)
  String data = '';
  ProductOrderBloc? _productOrderBloc;
  ProductOrderCount? productOrderCount;


  @override
  void initState() {
    super.initState();
    _productOrderBloc = BlocProvider.of(context);
    _productOrderBloc!.add(getCountEvent(type: 'jobticket'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _scan() async => {
          await FlutterBarcodeScanner.scanBarcode(
                  "#ff6666", "Cancel", false, ScanMode.DEFAULT)
              .then((barcode) {
            this.setState(() {
              data = barcode;
            });
          })
        };

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Job Ticket'),
        actions: <Widget>[
          IconButton(
              icon: SvgPicture.asset(
                "assets/images/Scan.svg",
              ),
              onPressed: () => _scan()),
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
        }, builder: (context, state) {
          if (state is ProductOrderCountSuccess) {
            return GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 5 / 1,
              children: [
                ListCardBadge(tittle: 'Open', count: state.productOrderCount.opens),
                ListCardBadge(tittle: 'Overdue', count: state.productOrderCount.overdue),
                ListCardBadge(tittle: 'Incomplete', count: state.productOrderCount.incompleted),
                ListCardBadge(tittle: 'Complete', count: state.productOrderCount.completed),
              ],
            );
          } else {
            if (productOrderCount != null){
              return GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 5 / 1,
                children: [
                  ListCardBadge(tittle: 'Open', count: productOrderCount!.opens),
                  ListCardBadge(tittle: 'Overdue', count: productOrderCount!.overdue),
                  ListCardBadge(tittle: 'Incomplete', count: productOrderCount!.incompleted),
                  ListCardBadge(tittle: 'Complete', count: productOrderCount!.completed),
                ],
              );
            }else {
              return Container(child: Text('123123'));
            }
          }
        }),
      ),
    );
  }
}
