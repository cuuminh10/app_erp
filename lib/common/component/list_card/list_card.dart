import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class ListCard extends StatelessWidget {
  final String tittle;
  final List<String> list;
  const ListCard({
    Key? key,
    required String this.tittle,
    required List<String> this.list
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          new Align(
            child: Container(child: Text(tittle, style: TextStyle(color: HexColor(kBlue500), fontSize: 15.0),), margin: EdgeInsets.only(left: 8.0),),
            alignment: Alignment.topLeft,
          ),
          SizedBox(height: size.height * 0.01),
          new Expanded(
              child: Container(
                child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 5 / 1,
                    children: List.generate(list.length, (index) {
                      return InkWell(
                        onTap: () => {
                          //Navigator pages
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          color: HexColor(kNormalBackground),
                          child: Center(
                            child: Row(
                              children: [
                                new Expanded(
                                  child: SvgPicture.asset(
                                    "assets/images/Jobticket.svg",
                                  ),
                                ),
                                new Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Item ${list[index]}',
                                    style: TextStyle(
                                        color: HexColor(kNormalString),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                new Expanded(
                                  child: SvgPicture.asset(
                                    "assets/images/add-disable.svg",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
              )),
        ],
      ),
    );
  }
}
