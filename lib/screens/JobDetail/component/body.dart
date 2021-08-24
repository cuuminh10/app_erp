import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/component/buttons/gmc_button_container.dart';
import 'package:gmc_erp/common/component/comment/CommenBox.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/screens/ListJobs/component/background.dart';
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
  int _selectedPage = 0;
  late PageController _pageController;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final listServer = ['one', 'two', 'three', 'Four'];
  List filedata = [
    {
      'name': 'Adeleye Ayodeji',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
  ];

  Widget commentChild(data) {
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
                            borderRadius: new BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                      ),
                    ),
                    title: Text(
                      data[i]['name'],
                      style: TextStyle(fontWeight: FontWeight.bold, color: HexColor(kBlue800)),
                    ),
                    subtitle: Text(data[i]['message']),

                  ),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(data[i]['message'],   style: TextStyle(color: HexColor(kBlue500)),)
                  ),
                )
              ],
            ),
          )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _productOrderBloc = BlocProvider.of(context);
    _productOrderBloc!.add(
        getPoOrderEvent(type: 'jobticket', statusType: this.widget.tittle));
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
                                    borderSide: new BorderSide(
                                        color: HexColor(kBlue100))),
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
                                    borderSide: new BorderSide(
                                        color: HexColor(kBlue100))),
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
                                    borderSide: new BorderSide(
                                        color: HexColor(kBlue100))),
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
                                    borderSide: new BorderSide(
                                        color: HexColor(kBlue100))),
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
                    Text('Desriptions',
                        style: TextStyle(
                            color: HexColor(kBlue800),
                            fontWeight: FontWeight.bold)),
                    Text('  • Tạo kết quả sản xuất cho thẻ giao việc',
                        style: TextStyle(color: HexColor(kBlue500))),
                    Text(
                        '  • Ghi nhận số lượng thực tế sản xuất, số lượng hàng hỏng',
                        style: TextStyle(color: HexColor(kBlue500))),
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
                            Expanded(
                              child: TabButton(
                                text: "Documents",
                                pageNumber: 2,
                                selectedPage: _selectedPage,
                                onPressed: () => {_changePage(2)},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.5,
                      child: PageView(
                        onPageChanged: (int page) {
                          setState(() {
                            _selectedPage = page;
                          });
                        },
                        controller: _pageController,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Table(
                                  border: TableBorder.all(
                                      width: 1.0, color: HexColor(kBlue500)),
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: HexColor(kBlue800)),
                                        children: [
                                          TableCell(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Item',
                                                  style: TextStyle(
                                                      color: HexColor(kWhite),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Gotham'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Phase',
                                                  style: TextStyle(
                                                      color: HexColor(kWhite),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Gotham'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Qty',
                                                  style: TextStyle(
                                                      color: HexColor(kWhite),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Gotham'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Unit',
                                                  style: TextStyle(
                                                      color: HexColor(kWhite),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Gotham'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Remark',
                                                  style: TextStyle(
                                                      color: HexColor(kWhite),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Gotham'),
                                                ),
                                              ),
                                            ],
                                          )),
                                        ]),
                                    for (var i = 0; i < listServer.length; i++)
                                      TableRow(
                                          decoration: BoxDecoration(
                                              color: i % 2 == 0
                                                  ? HexColor(kBlue100)
                                                  : HexColor(kBlue200)),
                                          children: [
                                            TableCell(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '123',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              kBlue800)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '123',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              kBlue800)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '123',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              kBlue800)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '123',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              kBlue800)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '123',
                                                      style: TextStyle(
                                                          color: HexColor(
                                                              kBlue800)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ])
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                             child: filedata.isEmpty ? Image.asset(
                            "assets/images/comment-place-holder.png",
                            alignment: Alignment.topCenter,
                          ) : Container(
                               child: CommentBox(
                                 userImage:
                                 "https://scontent.fsgn2-2.fna.fbcdn.net/v/t1.6435-9/124207683_3440092012749731_1279502413228474901_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=bv4Wsm-W7RQAX84Xg_Z&_nc_ht=scontent.fsgn2-2.fna&oh=bf3fe2fc238af306e3eb844b59a3fac2&oe=61490AF2",
                                 child: commentChild(filedata),
                                 labelText: 'Write a comment...',
                                 errorText: 'Comment cannot be blank',
                                 sendButtonMethod: () {
                                   if (formKey.currentState!.validate()) {
                                     print(commentController.text);
                                     setState(() {
                                       var value = {
                                         'name': 'New User',
                                         'pic':
                                         'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                                         'message': commentController.text
                                       };
                                       filedata.insert(0, value);
                                     });
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
                                 sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
                               ),
                             ),
                          ),
                          Container(
                            child: Text('123')
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: NormalButton(
                    text: "Result",
                    onPress: () => {},
                    vertical: 20,
                    horizontal: 40,
                    width: 0.5),
              )
            ],
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
  TabButton(
      {required this.text,
      required this.selectedPage,
      required this.pageNumber,
      required this.onPressed});

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
