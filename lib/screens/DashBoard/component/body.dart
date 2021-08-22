import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/common/component/dashboard/gmc_dashboard.dart';
import 'package:gmc_erp/common/component/list_card/list_card.dart';
import 'package:gmc_erp/screens/DashBoard/component/background.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> with TickerProviderStateMixin {
  final listServer = ['one', 'two', 'three', 'Four'];
  int _selectedPage = 0;
  late PageController _pageController;

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
  void initState() {
    _pageController = PageController();
    super.initState();
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
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Container(
                width: size.width * 0.7,
                decoration: new BoxDecoration(
                    color: HexColor(kBlue800),
                    borderRadius: BorderRadius.circular(9.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabButton(
                      text: "Short cut",
                      pageNumber: 0,
                      selectedPage: _selectedPage,
                      onPressed: () => {_changePage(0)},
                    ),
                    TabButton(
                      text: "All",
                      pageNumber: 1,
                      selectedPage: _selectedPage,
                      onPressed: () => {_changePage(1)},
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (int page) {
                  setState(() {
                    _selectedPage = page;
                  });
                },
                controller: _pageController,
                children: [
                  GmcDashBoard(list: listServer),
                  Container(
                    child: Column(
                      children: <Widget>[
                        new Expanded(child:  ListCard(tittle: 'Production', list:this.listServer)),
                        new Expanded(child:  ListCard(tittle: 'Production', list:this.listServer))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
            color: selectedPage == pageNumber
                ? HexColor(kBlue500)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
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
                    ? HexColor(kBlue100)
                    : HexColor(kBlue500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
