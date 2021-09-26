import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/models/Favor.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/public/ultis/filter_name_dashboard.dart';
import 'package:gmc_erp/public/ultis/ultis.dart';
import 'package:gmc_erp/screens/ListJobs/list_job_screen.dart';
import 'package:gmc_erp/screens/ResultList/result_list_screen.dart';
import 'package:hexcolor/hexcolor.dart';


class GmcDashBoard extends StatefulWidget {

  final List<Favor> list;
  const GmcDashBoard({Key key,  List<Favor> this.list})
      : super(key: key);

  @override
  _GmcDashBoard createState() => _GmcDashBoard();
}

class _GmcDashBoard extends State<GmcDashBoard> {

  int pos;

  List<Favor> tmpList;
  int variableSet = 0;
  ScrollController _scrollController;
  double width;
  double height;
  List<Favor> _favor;

  @override
  void initState() {
    tmpList = [...this.widget.list];
    _favor =  [...this.widget.list];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: DragAndDropGridView(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5 / 4,
        ),
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) => Opacity(
          opacity: pos != null ? pos == index ? 0.6 : 1 : 1,
          child: GestureDetector(
            onTap: ()  {
              final data = Ultis.filterScreensGMC(_favor[index].moduleName);
              final  wrapper = BaseInheritedWidget.of(context);
              BaseInheritedWidget.of(context).state.setInfoScreen(data);
              if (data['name'] != '') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return _favor[index].moduleName == 'ProductionFG' ? ListJobsScreen('Production Result')  :  ResultListScreen(infoScreen: Ultis.filterScreensGMC(_favor[index].moduleName));
                  }),
                );
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              color: HexColor(kNormalBackground),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/${FilterNameDashboard.FilterImage(_favor[index].moduleName)}",
                      ),
                      Text(
                        '${FilterNameDashboard.FilterName(_favor[index].moduleName)}',
                        style: TextStyle(
                            color: HexColor(kNormalString),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        itemCount: _favor.length,
        onWillAccept: (oldIndex, newIndex) {
          _favor = [...tmpList];
          int indexOfFirstItem = _favor.indexOf(_favor[oldIndex]);
          int indexOfSecondItem = _favor.indexOf(_favor[newIndex]);

          if (indexOfFirstItem > indexOfSecondItem) {
            for (int i = _favor.indexOf(_favor[oldIndex]);
            i > _favor.indexOf(_favor[newIndex]);
            i--) {
              var tmp = _favor[i - 1];
              _favor[i - 1] = _favor[i];
              _favor[i] = tmp;
            }
          } else {
            for (int i = _favor.indexOf(_favor[oldIndex]);
            i < _favor.indexOf(_favor[newIndex]);
            i++) {
              var tmp = _favor[i + 1];
              _favor[i + 1] = _favor[i];
              _favor[i] = tmp;
            }
          }

          setState(
                () {
              pos = newIndex;
            },
          );
          return true;
        },
        onReorder: (oldIndex, newIndex) {
          _favor = [...tmpList];
          int indexOfFirstItem = _favor.indexOf(_favor[oldIndex]);
          int indexOfSecondItem = _favor.indexOf(_favor[newIndex]);

          if (indexOfFirstItem > indexOfSecondItem) {
            for (int i = _favor.indexOf(_favor[oldIndex]);
            i > _favor.indexOf(_favor[newIndex]);
            i--) {
              var tmp = _favor[i - 1];
              _favor[i - 1] = _favor[i];
              _favor[i] = tmp;
            }
          } else {
            for (int i = _favor.indexOf(_favor[oldIndex]);
            i < _favor.indexOf(_favor[newIndex]);
            i++) {
              var tmp = _favor[i + 1];
              _favor[i + 1] = _favor[i];
              _favor[i] = tmp;
            }
          }
          tmpList = [..._favor];
          setState(
                () {
              pos = null;
            },
          );
        },
      ),
    );
  }
}

