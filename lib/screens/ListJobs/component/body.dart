import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/list_card/List_card_jobs.dart';
import 'package:gmc_erp/common/component/textfields/gmc_text_search.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:gmc_erp/models/DTO/request_product_dto.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/screens/JobDetail/job_detail_screen.dart';
import 'package:gmc_erp/screens/ListJobs/component/background.dart';
import 'package:gmc_erp/states/product_order_state.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  final String tittle;
  final RequestProductDTO requestProductDTO;

  const Body({Key key, this.tittle, this.requestProductDTO}) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String data = '';
  bool isExtended = false;
  ProductOrderBloc _productOrderBloc;
  List<ProductOrderOpen> _listProductOrderOpen = [];
  List<ProductOrderOpen> _listCloneProductOrderOpen = [];
  dynamic infoScreen;
  final TextEditingController controller = TextEditingController();
  bool displayTextSreach = false;

  @override
  void initState() {
    super.initState();
    _productOrderBloc = BlocProvider.of(context);
    Future.delayed(Duration.zero, () {
      infoScreen = BaseInheritedWidget.of(context).infoScreen;
      if (this.widget.requestProductDTO != null) {
        _productOrderBloc.add(getListPoOrderV2(
            screenCode: infoScreen['code'],
            requestProductDTO: this.widget.requestProductDTO));
      } else {
        _productOrderBloc.add(getPoOrderEvent(
            type: infoScreen['code'], statusType: this.widget.tittle));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void onHandleClickItem(String no) {
    _productOrderBloc
        .add(getPoOrderDetailEvent(type: infoScreen['code'], no: no));
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
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(this.widget.tittle),
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context, true)}),
          actions: <Widget>[
            IconButton(
                icon: SvgPicture.asset(
                  "assets/images/search.svg",
                ),
                onPressed: () => {
                      setState(() {
                        this.displayTextSreach = !this.displayTextSreach;
                      })
                    }),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocConsumer<ProductOrderBloc, ProductOrderState>(
              listener: (context, state) {
            if (state is ProductOrderSuccess) {
              this._listCloneProductOrderOpen = []
                ..addAll(state.productOrderOpen);
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
          }, builder: (context, state) {
            return Column(children: <Widget>[
              this.displayTextSreach
                  ? GmcTextSearch(
                      onChange: (e) => {
                            setState(() {
                              this._listProductOrderOpen = this
                                  ._listCloneProductOrderOpen
                                  .where((element) => element.no.contains(e))
                                  .toList();
                            })
                          },
                      onScan: () => scan(),
                      controller: controller)
                  : SizedBox(),
              Expanded(
                  child: renderListJobCard(
                      listProductOrderOpen: this._listProductOrderOpen,
                      onHandleClickItem: (e) => {this.onHandleClickItem(e)}))
            ]);
          }),
        ),
        floatingActionButton:  FloatingActionButton(
          backgroundColor: HexColor(kOrange600),
          onPressed: () => scanCreate(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class renderListJobCard extends StatelessWidget {
  final List<ProductOrderOpen> listProductOrderOpen;
  final Set<void> Function(String) onHandleClickItem;

  renderListJobCard(
      {this.listProductOrderOpen,
      Set<void> Function(String) this.onHandleClickItem});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (this.listProductOrderOpen.length > 0) {
      return GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 8 / 2,
          children: List.generate(
            this.listProductOrderOpen.length,
            (index) {
              return ListCardJobs(
                no: this.listProductOrderOpen[index].no,
                phaseName: this.listProductOrderOpen[index].phaseName,
                productDate: this.listProductOrderOpen[index].productDate,
                onTap: (e) => {onHandleClickItem(e)},
              );
            },
          ));
    } else {
      return SizedBox();
    }
  }
}
