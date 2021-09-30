import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:gmc_erp/models/Favor.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class ListCard extends StatelessWidget {
  final String tittle;
  final List<Favor> list;
  final List<Favor> listEnable;
  final Set<void> Function(dynamic) onTap;
  final Set<void> Function(dynamic) onMove;

  const ListCard(
      {Key key,
      String this.tittle,
      List<Favor> this.list,
      List<Favor> this.listEnable,
      Set<void> Function(dynamic) this.onTap,
      Set<void> Function(dynamic) this.onMove})
      : super(key: key);

  List<Favor> checkContains(String moduleName) {
    List<Favor> contain = listEnable
        .where((element) => element.moduleName == moduleName)
        .toList();

    return contain;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            new Align(
              child: Container(
                child: Text(
                  tittle,
                  style: TextStyle(color: HexColor(kBlue500), fontSize: 15.0),
                ),
                margin: EdgeInsets.only(left: 8.0),
              ),
              alignment: Alignment.topLeft,
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 6 / 1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 0),
                  children: List.generate(list.length, (index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      color: HexColor(kNormalBackground),
                      child: Center(
                        child: Row(
                          children: [
                            new Expanded(
                              child: GestureDetector(
                                onTap: () => {
                                  this.onMove(list[index].moduleName)
                                },
                                child: SvgPicture.asset(
                                  "assets/images/${list[index].image}",
                                ),
                              ),
                            ),
                            new Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () => {
                                  this.onMove(list[index].moduleName)
                                },
                                child: Text(
                                  '${list[index].name}',
                                  style: TextStyle(
                                      color: HexColor(kNormalString),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            new Expanded(
                              child: GestureDetector(
                                onTap: () => {
                                  this.onTap(list[index].moduleName)
                                 },
                                child: SvgPicture.asset(
                                  checkContains(list[index].moduleName)
                                              .length ==
                                          0
                                      ? "assets/images/add-disable.svg"
                                      : "assets/images/add-enable.svg",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
