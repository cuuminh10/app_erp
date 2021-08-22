import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/list_card/List_card_jobs.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/screens/ListJobs/component/background.dart';
import 'package:gmc_erp/states/product_order_state.dart';
import 'package:gmc_erp/public/constant/color.dart';

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
                  "assets/images/dot.svg",
                ),
                onPressed: () => {} //do something,
                ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: SingleChildScrollView(
            // This next line does the trick.
            scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          new Expanded(
                              flex: 3,
                              child: TextField(
                                  style: TextStyle(color: HexColor(kBlue500)),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: HexColor(kBlue100))),
                                      labelStyle: TextStyle(
                                          color: HexColor(kBlue800),
                                          fontWeight: FontWeight.bold),
                                      labelText: 'Job Ticket',
                                      hintText: 'Enter Job Ticket Here'))),
                          new Expanded(
                            child: SizedBox(height: size.width * 0.01),
                          ),
                          new Expanded(
                              flex: 3,
                              child: TextField(
                                  style: TextStyle(color: HexColor(kBlue500)),
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(color: HexColor(kBlue100))),
                                      labelStyle: TextStyle(
                                          color: HexColor(kBlue800),
                                          fontWeight: FontWeight.bold),
                                      labelText: 'Work Order',
                                      hintText: 'Enter Work Order Here'))),
                        ],
                      ),
                    ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                            flex: 3,
                            child: TextField(
                                style: TextStyle(color: HexColor(kBlue500)),
                                autocorrect: true,
                                decoration: InputDecoration(
                                    enabledBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(color: HexColor(kBlue100))),
                                    labelStyle: TextStyle(
                                        color: HexColor(kBlue800),
                                        fontWeight: FontWeight.bold),
                                    prefixIcon: SizedBox(
                                      child: SvgPicture.asset(
                                        "assets/images/prefix_date.svg",
                                      ), // myIcon is a 48px-wide widget.
                                    ),
                                    // set the prefix icon constraints
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 25,
                                      minHeight: 25,
                                    ),
                                    labelText: 'Date',
                                    hintText: 'Enter Date Here'))),
                        new Expanded(
                          child: SizedBox(width: size.width * 0.01),
                        ),
                        new Expanded(
                            flex: 3,
                            child: TextField(
                                style: TextStyle(color: HexColor(kBlue500)),
                                autocorrect: true,
                                decoration: InputDecoration(
                                    enabledBorder: new UnderlineInputBorder(
                                        borderSide: new BorderSide(color: HexColor(kBlue100))),
                                    labelStyle: TextStyle(
                                        color: HexColor(kBlue800),
                                        fontWeight: FontWeight.bold),
                                    labelText: 'PCI',
                                    prefixIcon: SizedBox(
                                      child: SvgPicture.asset(
                                        "assets/images/prefix_user.svg",
                                      ), // myIcon is a 48px-wide widget.
                                    ),
                                    // set the prefix icon constraints
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 25,
                                      minHeight: 25,
                                    ),
                                    hintText: 'Enter PCI Here'))),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Text('Desriptions',  style: TextStyle(color: HexColor(kBlue800), fontWeight: FontWeight.bold)),
                        Text('  • Tạo kết quả sản xuất cho thẻ giao việc',  style: TextStyle(color: HexColor(kBlue500))),
                        Text('  • Ghi nhận số lượng thực tế sản xuất, số lượng hàng hỏng',  style: TextStyle(color: HexColor(kBlue500))),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ),
        )
    );
  }
}
