import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:gmc_erp/models/Favor.dart';
import 'package:gmc_erp/screens/ResultList/result_list_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/public/ultis/filter_name_dashboard.dart';

class GmcDashBoard extends StatelessWidget {
  final List<Favor> list;
  const GmcDashBoard({Key? key, required List<Favor> this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 5 / 4,
          padding: EdgeInsets.only(top: 0),
          children: List.generate(list.length, (index) {
            return InkWell(
              onTap: () => {
                //Navigator pages
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return ResultListScreen();
                    }),
                  )
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
                          "assets/images/${FilterNameDashboard.FilterImage(list[index].moduleName)}",
                        ),
                        Text(
                          '${FilterNameDashboard.FilterName(list[index].moduleName)}',
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
            );
          })),
    );
  }
}
