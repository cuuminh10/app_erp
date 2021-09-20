import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/blocs/favor_bloc.dart';
import 'package:gmc_erp/common/component/dashboard/gmc_dashboard.dart';
import 'package:gmc_erp/common/component/list_card/list_card.dart';
import 'package:gmc_erp/events/favor_event.dart';
import 'package:gmc_erp/models/Favor.dart';
import 'package:gmc_erp/screens/DashBoard/component/background.dart';
import 'package:gmc_erp/states/favor_states.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> with TickerProviderStateMixin {
  List<Favor> listProduction = [];
  List<Favor> listPurchase = [];
  // _listProduction.add
  // new Favor(1, 'ProductionOrdr', 'Jobticket.svg','Job Ticket')
  int _selectedPage = 0;
  PageController _pageController;
  FavorBloc _favorBloc;
  Favor deleteFavor;
  List<Favor> _listFavor = [];

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

  List<Favor>  checkContains (String moduleName) {
    List<Favor>  contain = _listFavor.where((element) => element.moduleName == moduleName).toList();

    return contain;
  }

  void onHandleChangeFavor (String moduleName) {
    final favor = checkContains(moduleName);
    if (favor.length > 0) {
      _favorBloc.add(deleteFavorEvent(id: favor[0].id));
      setState(() {
        deleteFavor = favor[0];
      });
    }else {
      _favorBloc.add(postFavorEvent(moduleName: moduleName));
    }
  }

  @override
  void initState() {
    _pageController = PageController();
    _favorBloc = BlocProvider.of(context);
    listProduction
      ..add(new Favor(1, 'ProductionOrdr', 'Jobticket.svg', 'Job Ticket'))
      ..add(new Favor(
          2, 'ProductionFG', 'product-ressult.svg', 'Production Result'))
      ..add(new Favor(3, 'POPurchaseReceipt', 'GoodReceiptRequest.svg',
          'Good Receipt Request'));

    listPurchase
      ..add(new Favor(4, 'FGReceipt', 'Paper.svg', 'Good Receipt'))
      ..add(new Favor(
          5, 'PR', 'Purchase_Request.svg', 'Purchase Request'))
      ..add(new Favor(6, 'PO', 'purchase-order.svg',
          'Purchase Order'))
      ..add(new Favor(7, 'ApprovalProcessConfig', 'Paper.svg',
          'Approval Form'));
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
              child: BlocConsumer<FavorBloc, FavorState>(
                  listener: (context, state) {
                if (state is FavorSuccess) {
                  setState(() {
                    _listFavor = state.favor;
                  });
                }
                if (state is FavorPostSuccess) {
                  _listFavor.add(state.favor);
                  setState(() {
                    _listFavor = _listFavor;
                  });
                }
                if (state is FavorDeleteSuccess) {
                  _listFavor.removeWhere((element) => element.id == state.id);
                  setState(() {
                    _listFavor = _listFavor;
                  });
                }
              }, builder: (context, state) {
                return PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      _selectedPage = page;
                    });
                  },
                  controller: _pageController,
                  children: [
                    _listFavor.length > 0
                        ? GmcDashBoard(
                            list: _listFavor,
                          )
                        : SizedBox(child: Text(''),),
                    Container(
                      child: Column(
                        children: <Widget>[
                          new Expanded(
                              child: ListCard(
                                  tittle: 'Production', list: this.listProduction, listEnable: _listFavor,onTap: (e) => { onHandleChangeFavor(e)} )),
                          new Expanded(
                              child: ListCard(
                                  tittle: 'Purchase', list: this.listPurchase, listEnable: _listFavor, onTap: (e) => { onHandleChangeFavor(e)}))
                        ],
                      ),
                    ),
                  ],
                );
              }),
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
      { this.text,
       this.selectedPage,
       this.pageNumber,
       this.onPressed});

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
