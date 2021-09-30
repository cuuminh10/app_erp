import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/buttons/fancy.dart';
import 'package:gmc_erp/common/component/buttons/gmc_button_container.dart';
import 'package:gmc_erp/common/component/list_card/List_card_badge.dart';
import 'package:gmc_erp/common/component/popup/gmc_sort.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:gmc_erp/models/DTO/request_product_dto.dart';
import 'package:gmc_erp/models/DTO/response_product_dto.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/screens/JobDetail/job_detail_screen.dart';
import 'package:gmc_erp/screens/ResultList/component/background.dart';
import 'package:gmc_erp/states/product_order_state.dart';
import 'package:hexcolor/hexcolor.dart';

class Body extends StatefulWidget {
  final dynamic infoScreen;

  const Body({
    Key key,
    this.infoScreen
  }) : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String data = '';
  ProductOrderBloc _productOrderBloc;
  ProductOrderCount productOrderCount;
  AnimationController _animationController;
  List<ResponseProduct_1_DTO> _list = [];
  String groupBy = '';
  RequestProductDTO requestProductDTOSearch ;

  @override
  void initState() {
    super.initState();
    requestProductDTOSearch = RequestProductDTO();
    _productOrderBloc = BlocProvider.of(context);
    _productOrderBloc.add(getCountEvent(type: this.widget.infoScreen['code']));
    _productOrderBloc.add(getProductGroupEvent(requestProductDTO: RequestProductDTO(), screenCode: this.widget.infoScreen['code'] ));
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

  void groupByProduct (RequestProductDTO requestProductDTO) {
    if (requestProductDTO.groupByColumn.isNotEmpty) {
      setState(() {
        groupBy = requestProductDTO.groupByColumn;
      });
    }

    requestProductDTO.groupByColumn = groupBy;
    requestProductDTOSearch = requestProductDTO;
    _productOrderBloc.add(getProductGroupEvent(requestProductDTO: requestProductDTO, screenCode: this.widget.infoScreen['code'] ));
  }

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
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(this.widget.infoScreen['name']),
          actions: <Widget>[
            MyPopupMenu(
              child: Icon(
                Icons.sort_by_alpha_outlined,
                key: GlobalKey(),
                color: Colors.black87,
                size: 30,
              ),
                onGroupBy: (e) => groupByProduct(e)
            ),
            MyPopupMenu1(
              child: Icon(
                Icons.search,
                key: GlobalKey(),
                color: Colors.black87,
                size: 30,
              ),
                onGroupBy: (e) => groupByProduct(e)
            )
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

            }

            if (state is getProductGroupSuccess) {
              print('getProductGroupSuccess');
              setState(() {
                _list = state.list;
              });
            }

            if (state is ProductOrderFailer) {
              // set up the AlertDialog

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Error"),
                content: Text(state.error.toString()),
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
              return this._list.length > 0 ? GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 5 / 1,
                  children: List.generate(
                    this._list.length,
                        (index) {
                      return    ListCardBadge(
                          tittle: this._list[index].name,
                          count: this._list[index].counts,
                          requestProductDTO: this.requestProductDTOSearch,
                          onTap: (e) => {onHandleClickItem(e)});
                    },
                  )
              ) : SizedBox();
          }),
        ),
        floatingActionButton: FancyFab(onScan: () => scan(), onScanCreat: () => scanCreate(),),
      ),
    );
  }
}

class MyPopupMenu1 extends StatefulWidget {
  final Widget child;
  final void Function(RequestProductDTO requestProductDTO) onGroupBy;

  MyPopupMenu1({Key key, this.child, this.onGroupBy})
      : assert(child.key != null),
        super(key: key);

  @override
  _MyPopupMenuState createState() => _MyPopupMenuState();
}

class _MyPopupMenuState extends State<MyPopupMenu1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      onTap: _showPopupMenu,
    );
  }

  void _showPopupMenu() {
    //Find renderbox object
    RenderBox renderBox = (widget.child.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopupMenuContent(
            position: position,
            size: renderBox.size,
            onGroupBy: this.widget.onGroupBy,
            onAction: (x) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Action => $x'),
              ));
            },
          );
        });
  }
}

class PopupMenuContent extends StatefulWidget {
  final Offset position;
  final Size size;
  final ValueChanged<String> onAction;
  final void Function(RequestProductDTO requestProductDTO) onGroupBy;

  const PopupMenuContent({Key key, this.position, this.size, this.onAction, this.onGroupBy})
      : super(key: key);

  @override
  _PopupMenuContentState createState() => _PopupMenuContentState();
}

class _PopupMenuContentState extends State<PopupMenuContent>
    with SingleTickerProviderStateMixin {
  //Let's create animation
  AnimationController _animationController;
  Animation<double> _animation;
  String dropdownValue = '';
  TextEditingController _phaseTextFieldController = TextEditingController();
  TextEditingController _woTextFieldController = TextEditingController();
  TextEditingController _wcTextFieldController = TextEditingController();



  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _closePopup("");
        return false;
      },
      child: GestureDetector(
        onTap: () => _closePopup(""),
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right:
                      (MediaQuery.of(context).size.width - widget.position.dx) -
                          widget.size.width,
                  top: widget.position.dy + 100,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: const Offset(1.0, 2.0),
                        child: Opacity(opacity: _animation.value, child: child),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.maxFinite,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 8,
                              )
                            ]),
                        child: Column(
                          children: [
                            //Repeat now
                            GestureDetector(
                              onTap: () => _closePopup("repeatNow"),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE9FFE3),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Icon(
                                      Icons.task_alt_rounded,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text('Status'),
                                      value: dropdownValue,
                                      // icon: const Icon(Icons.arrow_downward),
                                      iconSize: 40,
                                       // elevation: 30,
                                      style: const TextStyle(
                                          color: Colors.deepPurple),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: <String>[
                                        '',
                                        'Open',
                                        'Overdue',
                                        'Incomplete',
                                        'Complete'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //Edit workout
                            SizedBox(
                              height: 16,
                            ),

                            GestureDetector(
                              onTap: () => _closePopup("editWorkout"),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFE1E1FC),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Color(0xFF3840A2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: TextField(
                                        style: TextStyle(color: HexColor(kBlue500)),
                                        controller: _phaseTextFieldController,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                            enabledBorder: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: HexColor(kBlue100))),
                                            labelStyle: TextStyle(
                                                color: HexColor(kBlue800),
                                                fontWeight: FontWeight.bold),
                                            hintText: 'Input search phase...',
                                            labelText: 'Phase')),
                                  ),
                                ],
                              ),
                            ),
                            //Share workout
                            SizedBox(
                              height: 16,
                            ),

                            GestureDetector(
                              onTap: () => _closePopup("Work Order"),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDDF3FD),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Icon(
                                      Icons.work,
                                      color: Color(0xFF0586C0),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: TextField(
                                        style: TextStyle(color: HexColor(kBlue500)),
                                        controller: _woTextFieldController,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                            enabledBorder: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: HexColor(kBlue100))),
                                            labelStyle: TextStyle(
                                                color: HexColor(kBlue800),
                                                fontWeight: FontWeight.bold),
                                            hintText: 'Input search Work Order...',
                                            labelText: 'Work Order')),
                                  ),
                                ],
                              ),
                            ),

                            //Share workout
                            SizedBox(
                              height: 16,
                            ),

                            GestureDetector(
                              onTap: () => _closePopup("Work Center"),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDDF2FD),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Icon(
                                      Icons.description,
                                      color: Color(0xFF0550C0),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: TextField(
                                        style: TextStyle(color: HexColor(kBlue500)),
                                        controller: _wcTextFieldController,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                            enabledBorder: new UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: HexColor(kBlue100))),
                                            labelStyle: TextStyle(
                                                color: HexColor(kBlue800),
                                                fontWeight: FontWeight.bold),
                                            hintText: 'Input search Work Center...',
                                            labelText: 'Work Center')),
                                  ),
                                ],
                              ),
                            ),
                            //Share workout
                            SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: NormalButton(
                                  text: 'Search',
                                  onPress: () => {

                                    this.widget.onGroupBy(RequestProductDTO(status: dropdownValue, phase: _phaseTextFieldController.text, workOrder: _woTextFieldController.text, workCenter: _wcTextFieldController.text))
                                  },
                                  vertical: 15,
                                  horizontal: 20,
                                  width: 0.5),
                            ),
                            //Share workout
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _closePopup(String action) {
    _animationController.reverse().whenComplete(() {
      Navigator.of(context).pop();

      if (action.isNotEmpty) widget.onAction?.call(action);
    });
  }
}
