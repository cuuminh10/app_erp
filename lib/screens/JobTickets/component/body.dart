import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/screens/Login/component/backgroud.dart';



class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> with TickerProviderStateMixin  {

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
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabButton(
                    text: "First Tab",
                    pageNumber: 0,
                    selectedPage: _selectedPage,
                    onPressed: () => {
                      _changePage(0)
                    },
                  ),
                  TabButton(
                    text: "Second Tab",
                    pageNumber: 1,
                    selectedPage: _selectedPage,
                    onPressed: () => {
                      _changePage(1)
                    },
                  ),
                ],
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
                  Container(
                    child: Center(
                      child: Text("Page 1"),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("Page 2"),
                    ),
                  )
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
  TabButton({required this.text, required this.selectedPage, required this.pageNumber, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(
            milliseconds: 1000
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: selectedPage == pageNumber ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 12.0 : 0,
          horizontal: selectedPage == pageNumber ? 20.0 : 0,
        ),
        margin: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 0 : 12.0,
          horizontal: selectedPage == pageNumber ? 0 : 20.0,
        ),
        child: Text(
          text ?? "Tab Button",
          style: TextStyle(
            color: selectedPage == pageNumber ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}