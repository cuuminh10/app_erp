import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/list_card/List_card_jobs.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:gmc_erp/public/ultis/ultis.dart';
import 'package:gmc_erp/screens/JobDetail/job_detail_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/screens/ListJobs/component/background.dart';
import 'package:gmc_erp/states/product_order_state.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/common/component/buttons/fancy.dart';


class Body extends StatefulWidget {
  final String tittle;

  const Body({Key? key, required this.tittle}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String data = '';
  bool isExtended = false;
  ProductOrderBloc? _productOrderBloc;
  late List<ProductOrderOpen> _listProductOrderOpen = [];
  dynamic infoScreen;

  @override
  void initState() {
    super.initState();
    _productOrderBloc = BlocProvider.of(context);
    Future.delayed(Duration.zero, () {
      infoScreen = BaseInheritedWidget.of(context)!.infoScreen;
      _productOrderBloc!.add(
          getPoOrderEvent(type: infoScreen['code'], statusType: this.widget.tittle));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onHandleClickItem(String no) {
    _productOrderBloc!.add(getPoOrderDetailEvent(type: infoScreen['code'], no: no));
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
      _productOrderBloc!.add(getNewPrScanEvent(no: barcode));
    })
  };

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget enbleButtons() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              // Respond to button press
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 8.0),
          FloatingActionButton(
            mini: true,
            onPressed: () {
              // Respond to button press
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 8.0),
          FloatingActionButton.extended(
            onPressed: () {
              // Respond to button press
            },
            icon: Icon(Icons.add),
            label: Text('EXTENDED'),
          ),
        ],
      );
    }

    return Background(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(this.widget.tittle),
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => {Navigator.pop(context, true)}),
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
              if (state is ProductOrderSuccess) {
                setState(() {
                  this._listProductOrderOpen = state.productOrderOpen;
                });
              }

              if (state is ProductOrderDetailSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return JobDetailScreen(
                        productOrderDetail: state.productOrderDetail);
                  }),
                );
              }
              //
              // if (state is ProductOrderCreateSuccess) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (_) {
              //       return JobDetailScreen(
              //           productOrderDetail: state.productOrderDetail, isNewProduct: true,);
              //     }),
              //   );
              // }
            }, builder: (context, state) {
              return this._listProductOrderOpen.length > 0
                  ? GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 8 / 2,
                      children: List.generate(
                        this._listProductOrderOpen.length,
                        (index) {
                          return ListCardJobs(
                            no: this._listProductOrderOpen[index].no,
                            phaseName:
                                this._listProductOrderOpen[index].phaseName,
                            productDate:
                                this._listProductOrderOpen[index].productDate,
                            onTap: (e) => {onHandleClickItem(e)},
                          );
                        },
                      ))
                  : SizedBox();
            }),
          ),
          floatingActionButton: FancyFab(onScan: () => scanCreate()),
          // floatingActionButton: FloatingActionButton.extended(
          //     backgroundColor: HexColor(kOrange600),
          //     onPressed: () => {
          //           setState(() {
          //             isExtended = !isExtended;
          //           })
          //         },
          //     label: AnimatedSwitcher(
          //       duration: Duration(seconds: 1),
          //       transitionBuilder:
          //           (Widget child, Animation<double> animation) =>
          //               FadeTransition(
          //         opacity: animation,
          //         child: SizeTransition(
          //           child: child,
          //           sizeFactor: animation,
          //           axis: Axis.horizontal,
          //         ),
          //       ),
          //       child: !isExtended
          //           ? SvgPicture.asset(
          //               "assets/images/Paper.svg",
          //               width: 20.0,
          //               height: 20.0,
          //               color: HexColor(kWhite),
          //             )
          //           : Row(
          //               children: [
          //                 Padding(
          //                     padding: const EdgeInsets.only(right: 4.0),
          //                     child: SvgPicture.asset("assets/images/Paper.svg",
          //                         width: 20.0,
          //                         height: 20.0,
          //                         color: HexColor(kWhite))),
          //                 Text("EXTEND")
          //               ],
          //             ),
          //     ))
      ),
    );
  }
}
