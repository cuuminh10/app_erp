import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:gmc_erp/screens/JobDetail/job_detail_screen.dart';
import 'package:gmc_erp/screens/ListJobs/list_job_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';
import 'package:gmc_erp/public/ultis/convert_date.dart';

class ListCardJobs extends StatelessWidget {
  final String no;
  final String phaseName;
  final String productDate;
  final Set<void> Function(String) onTap;

  const ListCardJobs(
      {Key? key, required String this.no, required String this.phaseName, required String this.productDate, required Set<void> Function(String) this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) {
        //     return JobDetailScreen(tittle: no,);
        //   }),
        // ),

        this.onTap(no)
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: HexColor(kNormalBackground),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              new Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  "assets/images/Paper.svg",
                  width: 24.0,
                  height: 30.0,
                ),
              ),
              new Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Expanded(
                          child: Text(
                        '${no}',
                        style: TextStyle(
                            color: HexColor(kBlue800),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      )),
                      new Expanded(
                          child: Text.rich(TextSpan(children: <InlineSpan>[
                        TextSpan(text: 'in', style: TextStyle(fontSize: 14.0)),
                        TextSpan(
                            text: ' ${phaseName}',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: HexColor(kBlue800),
                                fontWeight: FontWeight.bold)),
                      ]))),
                      new Expanded(child: Text('${ConvertDate.ConvertDateTime(productDate)}'))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
    ;
  }
}
