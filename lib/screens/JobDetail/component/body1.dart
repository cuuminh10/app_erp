import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/file_comment_bloc.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/buttons/gmc_button_dotted.dart';
import 'package:gmc_erp/common/component/comment/CommenBox.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/events/file_comment_event.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/public/ultis/convert_date.dart';
import 'package:gmc_erp/public/ultis/ultis.dart';
import 'package:gmc_erp/screens/ListJobs/component/background.dart';
import 'package:gmc_erp/screens/RemarkDetail/remark_detail_screen.dart';
import 'package:gmc_erp/states/file_comment_state.dart';
import 'package:gmc_erp/states/product_order_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  final ProductOrderDetail productOrderDetail;
  final bool isNewProduct;

  const Body({Key key, this.productOrderDetail, this.isNewProduct})
      : super(key: key);

  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String data = '';
  ProductOrderBloc _productOrderBloc;
  int _selectedPage = 0;
  PageController _pageController;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final listServer = ['one', 'two', 'three', 'Four'];
  final TextEditingController _dateTextFieldController =
      TextEditingController();
  final TextEditingController _userTextFieldController =
      TextEditingController();
  final TextEditingController _woTextFieldController = TextEditingController();
  final TextEditingController _noTextFieldController = TextEditingController();
  List<Comment> _comments = [];
  List<Attach> _attach = [];
  FileCommentBloc _fileCommentBloc;
  dynamic infoScreen;
  final TextEditingController _descriptionTextFieldController =
      TextEditingController();

  Future _openFileExplorer(List<String> files) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: files,
    );

    if (result != null) {
      // print(result);
      _fileCommentBloc.add(postAttach(
          type: infoScreen["code"],
          objectId: this.widget.productOrderDetail.id,
          file: result.files[0].path));
    } else {
      // User canceled the picker
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image != null) {
        _fileCommentBloc.add(postAttach(
            type: infoScreen["code"],
            objectId: this.widget.productOrderDetail.id,
            file: image.path));
      }
    } catch (exception) {
      log('Take photo error');
    }
  }

  String _launched = 'Unknown';

  Future<void> _makeCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget commentChild(List<Comment> data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 2.0, 0.0),
            child: Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () async {
                      // Display the image in large form.
                      print("Comment Clicked");
                    },
                    child: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: new BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(50))),
                      // child: CircleAvatar(
                      //     radius: 50,
                      //     backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                      child: CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        child: Text('${data[i].createUser}'),
                      ),
                    ),
                  ),
                  title: Text(
                    data[i].createUser,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: HexColor(kBlue800)),
                  ),
                  subtitle: Text(
                      '${ConvertDate.ConvertDateTime(data[i].createDate)}'),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        data[i].comment,
                        style: TextStyle(color: HexColor(kBlue500)),
                      )),
                )
              ],
            ),
          )
      ],
    );
  }

  Widget renderTableCell(dynamic name, int index) {
    return TableCell(
      child: GestureDetector(
        onTap: () => this.infoScreen["code"] == "producResult"
            ? {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RemarkDetailScreen(
                            this.widget.productOrderDetail.listDetail[index],
                            this
                                .widget
                                .productOrderDetail
                                .no))).then((detail) => {
                      if (detail is Detail)
                        {
                          setState(() {
                            this.widget.productOrderDetail.listDetail[index] =
                                detail;
                          })
                        }
                    })
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name.toString(),
            style: TextStyle(color: HexColor(kBlue800)),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fileCommentBloc = BlocProvider.of(context);
    _pageController = PageController();
    _productOrderBloc = BlocProvider.of(context);
    _dateTextFieldController.value = TextEditingValue(
        text: ConvertDate.ConvertDateTime(
            this.widget.productOrderDetail.ordDate));
    _userTextFieldController.value =
        TextEditingValue(text: this.widget.productOrderDetail.employeeName);
    _woTextFieldController.value = TextEditingValue(
        text: this.widget.productOrderDetail.workCenterName);
    _comments = this.widget.productOrderDetail.listComment;

    _noTextFieldController.value =
        TextEditingValue(text: this.widget.productOrderDetail.phaseNo);

    _descriptionTextFieldController.value =
        TextEditingValue(text: this.widget.productOrderDetail.description);

    this.widget.isNewProduct == true
        ? infoScreen = Ultis.filterScreensGMC('ProductionFG')
        : Future.delayed(Duration.zero, () {
            setState(() {
              infoScreen = BaseInheritedWidget.of(context).infoScreen;
            });
          });

    setState(() {
      _comments = this.widget.productOrderDetail.listComment;
      _attach = this.widget.productOrderDetail.listAttach;
    });
  }

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  void _onHandleButton() {
    if (this.infoScreen["code"] == "jobticket") {
      _productOrderBloc
          .add(getNewPrScanEvent(no: this.widget.productOrderDetail.no));
    } else {
      Map<String, dynamic> body = {
        "description": this.widget.productOrderDetail.description,
        "detail": this.widget.productOrderDetail.listDetail
      };

      this.widget.isNewProduct == true
          ? _productOrderBloc.add(postNewPrEvent(
              no: this.widget.productOrderDetail.phaseNo, detail: body))
          : _productOrderBloc.add(putPrDeatilEvent(
              detail: body, id: this.widget.productOrderDetail.id));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(this.widget.productOrderDetail.no),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => {Navigator.pop(context, true)}),
        actions: <Widget>[
          GestureDetector(
            onTap: () => {_onHandleButton()},
            child: Center(
                child: Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      this.infoScreen["code"] ==
                          "jobticket"
                          ? "Result"
                          : "Save",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: HexColor(kBlue500)),
                    ))),
          )
        ],
      ),
      body: SizedBox(
        height: size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
          child: SingleChildScrollView(
            // This next line does the trick.
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.widget.productOrderDetail.no,
                  style: TextStyle(
                      fontFamily: 'Gotham',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#002158')),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                          flex: 3,
                          child: TextField(
                              style: TextStyle(
                                  color: HexColor(KContent),
                                  fontWeight: FontWeight.w600),
                              controller: _noTextFieldController,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: HexColor(kBlue100))),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: HexColor(KContent)),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/phase_icon.svg",
                                    ), // myIcon is a 48px-wide widget.
                                  ),
                                  // set the prefix icon constraints
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 25,
                                    minHeight: 25,
                                  ),
                                  labelText: this.infoScreen['label_topLeft'],
                                  hintText: 'Enter Job Ticket Here'))),
                      new Expanded(
                        child: SizedBox(height: size.width * 0.01),
                      ),
                      new Expanded(
                          flex: 3,
                          child: TextField(
                              style: TextStyle(
                                  color: HexColor(KContent),
                                  fontWeight: FontWeight.w600),
                              controller: _woTextFieldController,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: HexColor(kBlue100))),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: HexColor(KContent)),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/work_center.svg",
                                    ), // myIcon is a 48px-wide widget.
                                  ),
                                  // set the prefix icon constraints
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 25,
                                    minHeight: 25,
                                  ),
                                  labelText: this.infoScreen['label_topRight'],
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
                              style: TextStyle(
                                  color: HexColor(KContent),
                                  fontWeight: FontWeight.w600),
                              controller: _userTextFieldController,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: HexColor(kBlue100))),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: HexColor(KContent)),
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: CircleAvatar(
                                      backgroundColor: HexColor('#F178B6'),
                                      child: Text('${Ultis.cutName(this.widget.productOrderDetail.employeeName)}', style: TextStyle(color: Colors.white),),
                                    ), // myIcon is a 48px-wide widget.
                                  ),
                                  // set the prefix icon constraints
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 25,
                                    minHeight: 25,
                                  ),
                                  labelText:
                                      this.infoScreen['label_bottomLeft'],
                                  hintText: ''))),
                      new Expanded(
                        child: SizedBox(width: size.width * 0.01),
                      ),
                      new Expanded(
                          flex: 3,
                          child: TextField(
                              style: TextStyle(
                                  color: HexColor(KContent),
                                  fontWeight: FontWeight.w600),
                              controller: _dateTextFieldController,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: HexColor(kBlue100))),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: HexColor(KContent)),
                                  labelText:
                                      this.infoScreen['label_bottomRight'],
                                  prefixIcon: Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: SvgPicture.asset(
                                      "assets/images/due_date.svg",
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
                      Text('Desriptions',
                          style: TextStyle(
                              color: HexColor(kBlue800),
                              fontWeight: FontWeight.bold)),
                      this.infoScreen["code"] == "jobticket"
                          ? Text(this.widget.productOrderDetail.description,
                              style: TextStyle(color: HexColor(kBlue500)))
                          : TextField(
                              style: TextStyle(color: HexColor(kBlue500)),
                              controller: _descriptionTextFieldController,
                              showCursor: true,
                              decoration: InputDecoration(
                                  enabledBorder: new UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: HexColor(kBlue100))),
                                  labelStyle: TextStyle(
                                      color: HexColor(kBlue800),
                                      fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TabButton(
                                  text: "Details",
                                  pageNumber: 0,
                                  selectedPage: _selectedPage,
                                  onPressed: () => {_changePage(0)},
                                ),
                              ),
                              Expanded(
                                child: TabButton(
                                  text: "Comments",
                                  pageNumber: 1,
                                  selectedPage: _selectedPage,
                                  onPressed: () => {_changePage(1)},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.6,
                        child: PageView(
                          onPageChanged: (int page) {
                            setState(() {
                              _selectedPage = page;
                            });
                          },
                          controller: _pageController,
                          children: [
                            BlocListener<ProductOrderBloc, ProductOrderState>(
                              listener: (context, state) async {
                                if (state is ProductOrderPostSuccess ||
                                    state is ProductOrderPutDetailSuccess) {
                                  Navigator.pop(context, true);
                                }

                                if (state is ProductOrderDetailSuccess) {
                                  print('12333333');
                                }
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: GridView.count(
                                      crossAxisCount: 1,
                                      childAspectRatio: 7 / 3,
                                      children: List.generate(
                                          this
                                              .widget
                                              .productOrderDetail
                                              .listDetail
                                              .length, (index) {
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: HexColor(kBlue200),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          elevation: 7.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: GestureDetector(
                                            onTap: () => this
                                                        .infoScreen["code"] ==
                                                    "producResult"
                                                ? {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => RemarkDetailScreen(
                                                                this
                                                                        .widget
                                                                        .productOrderDetail
                                                                        .listDetail[
                                                                    index],
                                                                this
                                                                    .widget
                                                                    .productOrderDetail
                                                                    .no))).then(
                                                        (detail) => {
                                                              if (detail
                                                                  is Detail)
                                                                {
                                                                  setState(() {
                                                                    this
                                                                        .widget
                                                                        .productOrderDetail
                                                                        .listDetail[index] = detail;
                                                                  })
                                                                }
                                                            })
                                                  }
                                                : null,
                                            child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "#${this.widget.productOrderDetail.listDetail[index].productNo.toString()}",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                kBlue500),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                      Text(
                                                          this
                                                              .widget
                                                              .productOrderDetail
                                                              .listDetail[index]
                                                              .qty
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  kBlue500)))
                                                    ],
                                                  )),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 7.0),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: HexColor(
                                                                      kBlue200),
                                                                  width: 1))),
                                                      child: SizedBox(
                                                        height:
                                                            size.height * 0.01,
                                                        width: size.width,
                                                      )),
                                                  Expanded(
                                                      child: Text(
                                                          this
                                                              .widget
                                                              .productOrderDetail
                                                              .listDetail[index]
                                                              .phaseName,
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  kBlue500)))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 7.0),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: HexColor(
                                                                      kBlue200),
                                                                  width: 1))),
                                                      child: SizedBox(
                                                        height:
                                                            size.height * 0.01,
                                                        width: size.width,
                                                      )),
                                                  Expanded(
                                                      child: Text(
                                                          this
                                                              .widget
                                                              .productOrderDetail
                                                              .listDetail[index]
                                                              .phaseName,
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  kBlue500)))),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 7.0),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color: HexColor(
                                                                      kBlue200),
                                                                  width: 1))),
                                                      child: SizedBox(
                                                        height:
                                                            size.height * 0.01,
                                                        width: size.width,
                                                      )),
                                                  Expanded(
                                                      child: Text(
                                                          this
                                                              .widget
                                                              .productOrderDetail
                                                              .listDetail[index]
                                                              .unit,
                                                          style: TextStyle(
                                                              color: HexColor(
                                                                  kBlue500))))
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }))),
                            ),
                            Container(
                              child: BlocListener<FileCommentBloc,
                                  FileCommentState>(
                                listener: (context, state) {
                                  if (state is FileCommentStateSuccess) {
                                    _comments.insert(0, state.comments);
                                    setState(() {
                                      _comments = _comments;
                                    });
                                  }
                                },
                                child: CommentBox(
                                  userImage:
                                      "https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.6435-9/124207683_3440092012749731_1279502413228474901_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=bv4Wsm-W7RQAX84Xg_Z&_nc_ht=scontent.fsgn2-2.fna&oh=bf3fe2fc238af306e3eb844b59a3fac2&oe=61490AF2",
                                  child: this._comments.length > 0
                                      ? commentChild(this._comments)
                                      : Container(
                                          height: size.height * 0.4,
                                          margin: EdgeInsets.only(top: 70.0),
                                          child: Image.asset(
                                            "assets/images/comment-place-holder.png",
                                            alignment: Alignment.topCenter,
                                          )),
                                  labelText: 'Write a comment...',
                                  errorText: 'Comment cannot be blank',
                                  sendButtonMethod: () {
                                    if (formKey.currentState.validate()) {
                                      print(commentController.text);
                                      ProductOrderDetail productOrderDetail =
                                          this.widget.productOrderDetail;

                                      _fileCommentBloc.add(postComment(
                                          type: 'jobticket',
                                          no: productOrderDetail.id.toString(),
                                          content: commentController.text));
                                      commentController.clear();
                                      FocusScope.of(context).unfocus();
                                    } else {
                                      print("Not validated");
                                    }
                                  },
                                  formKey: formKey,
                                  commentController: commentController,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  sendWidget: Icon(Icons.send_sharp,
                                      size: 30, color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: this._attach.length == 0 ? 70.0 : 0),
                                child: this._attach.length == 0
                                    ? SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.asset(
                                              "assets/images/attachment-place-holder.png",
                                              alignment: Alignment.topCenter,
                                            ),
                                            SizedBox(
                                                height: size.height * 0.02),
                                            Text(
                                              'There are no any documents yet',
                                              style: TextStyle(
                                                  color: HexColor(kBlue800),
                                                  fontFamily: 'Gotham',
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14.0),
                                            ),
                                            SizedBox(
                                                height: size.height * 0.02),
                                            DottedButton(
                                              text: "Attachment",
                                              onPress: (e) =>
                                                  {_openFileExplorer(e)},
                                              onPickImage: () => {pickImage()},
                                              vertical: 15,
                                              horizontal: 40,
                                              width: 0.48,
                                              color: HexColor(kWhite),
                                              colorText: HexColor(kBlue900),
                                            )
                                          ],
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        child: BlocListener<FileCommentBloc,
                                            FileCommentState>(
                                          listener: (context, state) {
                                            if (state
                                                is FileAttachStateSuccess) {
                                              _attach.insert(0, state.attach);
                                              setState(() {
                                                _attach = _attach;
                                              });
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.5,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        this._attach.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            GestureDetector(
                                                      onTap: () => {
                                                        _makeCall(
                                                            'http://175.41.183.152:8080/fc/viewFile/jobticket/${this._attach[index].saveName}')
                                                      },
                                                      child: Card(
                                                        elevation: 1,
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: !Ultis.isImages(
                                                                this
                                                                    ._attach[
                                                                        index]
                                                                    .realName)
                                                            ? ListTile(
                                                                leading:
                                                                    SvgPicture
                                                                        .asset(
                                                                  Ultis.isFile(this
                                                                      ._attach[
                                                                          index]
                                                                      .saveName),
                                                                ),
                                                                title: Text(this
                                                                    ._attach[
                                                                        index]
                                                                    .realName),
                                                                subtitle: Text(this
                                                                    ._attach[
                                                                        index]
                                                                    .createUser),
                                                                //  trailing: Icon(Icons.add_a_photo),
                                                              )
                                                            : Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: SizedBox(
                                                                  child: Image
                                                                      .network(
                                                                    'http://175.41.183.152:8080/fc/viewFile/${this.infoScreen["code"]}/${this._attach[index].saveName}',
                                                                    width: 100,
                                                                    height: 100,
                                                                  ),
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  )),
                                              // Center(
                                              //   child: DottedButton(
                                              //     text: "Attachment",
                                              //     onPress: (e) =>
                                              //         {_openFileExplorer(e)},
                                              //     onPickImage: () =>
                                              //         {pickImage()},
                                              //     vertical: 15,
                                              //     horizontal: 40,
                                              //     width: 0.48,
                                              //     color: HexColor(kWhite),
                                              //     colorText: HexColor(kBlue900),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Center(
                //   child: NormalButton(
                //       text: "Result",
                //       onPress: () => {},
                //       vertical: 20,
                //       horizontal: 40,
                //       width: 0.5),
                // )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class TabButton extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final Set<void> Function() onPressed;

  TabButton({this.text, this.selectedPage, this.pageNumber, this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.33,
      padding: EdgeInsets.symmetric(
        vertical: 3.0,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          decoration: BoxDecoration(
            // color: selectedPage == pageNumber
            //     ? HexColor(kBlue500)
            //     : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: selectedPage == pageNumber
                    ? HexColor(kBlue800)
                    : Colors.transparent,
                width: 4.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 12.0 : 0,
            horizontal: selectedPage == pageNumber ? 20.0 : 0,
          ),
          margin: EdgeInsets.symmetric(
            vertical: selectedPage == pageNumber ? 0 : 12.0,
            horizontal: selectedPage == pageNumber ? 0 : 20.0,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: selectedPage == pageNumber
                      ? HexColor(kBlue800)
                      : HexColor(kBlue500),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
