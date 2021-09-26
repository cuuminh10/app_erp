import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/common/component/buttons/gmc_button_container.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/screens/ListJobs/component/background.dart';
import 'package:hexcolor/hexcolor.dart';

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
  final TextEditingController _finishQtyTextFieldController =
      TextEditingController();
  final TextEditingController _setupQtyTextFieldController =
      TextEditingController();
  final TextEditingController _ncrQtyTextFieldController =
      TextEditingController();
  final TextEditingController _cancelQtyTextFieldController =
      TextEditingController();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _nameTextFieldController.value = TextEditingValue(
        text: 'item ' + this.widget.detail.productNo.toString());
    _finishQtyTextFieldController.value =
        TextEditingValue(text: this.widget.detail.qty.toString());
    _setupQtyTextFieldController.value =
        TextEditingValue(text: this.widget.detail.setUpQty.toString());
    _ncrQtyTextFieldController.value =
        TextEditingValue(text: this.widget.detail.ncrQty.toString());
    _cancelQtyTextFieldController.value =
        TextEditingValue(text: this.widget.detail.cancelQty.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void _showPopupMenu(GlobalKey key) {
      //Find renderbox object
      RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);

      showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return PopupMenuContent(
              position: position,
              size: renderBox.size,
              onAction: (x) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Action => $x'),
                ));
              },
            );
          });
    }

    return Background(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(this.widget.no),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context, true)}),
        actions: <Widget>[
          GestureDetector(
            onTap: () => {Navigator.pop(context, this.widget.detail)},
            child: Center(
                child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Done',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: HexColor(kBlue500)),
                    ))),
          )
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
                0: FlexColumnWidth(4),
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
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: HexColor(kBlue200), width: 1))),
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
                          child: MyPopupMenu1(
                              child: Text(
                                this.widget.detail.qty.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: HexColor(kBlue800)),
                                key: GlobalKey(),
                              ),
                              onChange: (e) => {
                                    setState(() {
                                      this.widget.detail.qty = e;
                                    })
                                  },
                              data: this.widget.detail.qty as double),
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
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: HexColor(kBlue200), width: 1))),
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
                          child: MyPopupMenu1(
                              child: Text(
                                this.widget.detail.setUpQty.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: HexColor(kBlue800)),
                                key: GlobalKey(),
                              ),
                              onChange: (e) => {
                                    setState(() {
                                      this.widget.detail.setUpQty = e;
                                    })
                                  },
                              data: this.widget.detail.setUpQty as double),
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
                              onPressed: () => {
                                setState(() {
                                  this.widget.detail.setUpQty++;
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
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: HexColor(kBlue200), width: 1))),
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
                              onPressed: this.widget.detail.ncrQty != 0
                                  ? () => {
                                        setState(() {
                                          this.widget.detail.ncrQty--;
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
                          child: MyPopupMenu1(
                              child: Text(
                                this.widget.detail.ncrQty.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: HexColor(kBlue800)),
                                key: GlobalKey(),
                              ),
                              onChange: (e) => {
                                    setState(() {
                                      this.widget.detail.ncrQty = e;
                                    })
                                  },
                              data: this.widget.detail.ncrQty as double),
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
                              onPressed: () => {
                                setState(() {
                                  this.widget.detail.ncrQty++;
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
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: HexColor(kBlue200), width: 1))),
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
                              onPressed: this.widget.detail.cancelQty != 0
                                  ? () => {
                                        setState(() {
                                          this.widget.detail.cancelQty--;
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
                          child: MyPopupMenu1(
                              child: Text(
                                this.widget.detail.cancelQty.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: HexColor(kBlue800)),
                                key: GlobalKey(),
                              ),
                              onChange: (e) => {
                                    setState(() {
                                      this.widget.detail.cancelQty = e;
                                    })
                                  },
                              data: this.widget.detail.cancelQty as double),
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
                              onPressed: () => {
                                setState(() {
                                  this.widget.detail.cancelQty++;
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
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class MyPopupMenu1 extends StatefulWidget {
  final Widget child;
  final void Function(double value) onChange;
  final double data;

  MyPopupMenu1({Key key, this.child, this.onChange, this.data})
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
            data: this.widget.data,
            onChange: this.widget.onChange,
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
  final double data;
  final void Function(double value) onChange;

  const PopupMenuContent(
      {Key key,
      this.position,
      this.size,
      this.onAction,
      this.data,
      this.onChange})
      : super(key: key);

  @override
  _PopupMenuContentState createState() => _PopupMenuContentState();
}

class _PopupMenuContentState extends State<PopupMenuContent>
    with SingleTickerProviderStateMixin {
  //Let's create animation
  AnimationController _animationController;
  Animation<double> _animation;
  String dropdownValue = 'Open';
  final TextEditingController _dataTextFieldController =
      TextEditingController();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    super.initState();
    _dataTextFieldController.value =
        TextEditingValue(text: this.widget.data.toString());
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
                  right: 0,
                  top: widget.position.dy / 2,
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: TextField(
                                        style: TextStyle(
                                            color: HexColor(kBlue500)),
                                        controller: _dataTextFieldController,
                                        keyboardType: TextInputType.number,
                                        onChanged: (e) => this
                                            .widget
                                            .onChange(double.parse(e)),
                                        showCursor: true,
                                        decoration: InputDecoration(
                                            enabledBorder:
                                                new UnderlineInputBorder(
                                                    borderSide: new BorderSide(
                                                        color: HexColor(
                                                            kBlue100))),
                                            labelStyle: TextStyle(
                                                color: HexColor(kBlue800),
                                                fontWeight: FontWeight.bold),
                                            hintText:
                                                'Input value',
                                            labelText: 'Qty')),
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
                                  text: 'Save',
                                  onPress: () => {},
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
