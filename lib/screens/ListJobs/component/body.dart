import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/list_card/List_card_jobs.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:gmc_erp/states/product_order_state.dart';

class Body extends StatefulWidget {
  final String tittle;

  const Body({Key? key, required this.tittle}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String data = '';
  ProductOrderBloc? _productOrderBloc;

  @override
  void initState() {
    super.initState();
    _productOrderBloc = BlocProvider.of(context);
    _productOrderBloc!.add(
        getPoOrderEvent(type: 'jobticket', statusType: this.widget.tittle));
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
        title: Text(this.widget.tittle),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context, true) }
        ),
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
          // do stuff here based on BlocA's state
        }, builder: (context, state) {
          if (state is ProductOrderSuccess) {
            return GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 8 / 2,
                children: List.generate(
                  state.productOrderOpen.length,
                  (index) {
                    return ListCardJobs(
                      no: state.productOrderOpen[index].no,
                      phaseName: state.productOrderOpen[index].phaseName,
                      productDate: state.productOrderOpen[index].productDate,
                    );
                  },
                ));
          } else {
            return Container(
              child: Text(''),
            );
          }
        }),
      ),
    );
  }
}
