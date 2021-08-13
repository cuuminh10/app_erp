import 'package:flutter/material.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/screens/Login/component/backgroud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gmc_erp/common/component/textfields/normal_field_container.dart';
import 'package:gmc_erp/common/component/textfields/password_field_container.dart';
import 'package:gmc_erp/common/component/textfields/server_field_container.dart';
import 'package:gmc_erp/common/component/buttons/gmc_button_container.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:gmc_erp/public/constant/color.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  String username = "";
  String password = "";
  bool hidePassword = true;
  final listServer = ['one', 'two', 'three', 'Four'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var counter = BaseInheritedWidget.of(context)!.myData;
    return SafeArea(
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: size.width * 0.6,
                child: SvgPicture.asset(
                  "assets/images/logo_expert_erp.svg",
                  height: size.height * 0.35,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              NormalTextField(hintText: "Username *", onChanged: (value) => {}),
              SizedBox(height: size.height * 0.01),
              PasswordTextField(
                  hintText: "Password *",
                  hidePassword: this.hidePassword,
                  onChanged: (value) => {},
                  onPress: () => {
                        setState(() {
                          this.hidePassword = !this.hidePassword;
                        })
                      }),
              SizedBox(height: size.height * 0.01),
              ServerTextField(
                  hintText: "Server",
                  onChanged: (value) => {},
                  onPress: () => {this._showModal(this.listServer)}),
              SizedBox(height: size.height * 0.04),
              NormalButton(
                  text: "Login",
                  onPress: () => {
                    BaseInheritedWidget.of(context)!.state.changePageIndex(2),
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                        Text('${counter}'),
                      ),
                    ),
                  },
                  vertical: 20,
                  horizontal: 40,
                  width: 0.8),
              SizedBox(height: size.height * 0.4),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(List<String> listServer) {
    Size size = MediaQuery.of(context).size;
    var counter = BaseInheritedWidget.of(context)!.myData;
    final snackBar = ScaffoldMessenger.of(context);
    final _formKey = GlobalKey<FormState>();
    Future<void> future = showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                Container(
                  width: size.width * 0.9,
                  height: size.height * 0.03,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel_outlined),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Center(
                        child: Text('What server would you choose?'),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                NormalButton(
                  text: "+   Add new server",
                  onPress: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      'Add new server',
                                      style: TextStyle(
                                          color: HexColor(kNormalString),
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: NormalTextField(
                                      hintText: "Server name",
                                      onChanged: (value) => {}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: NormalButton(
                                      text: "Add",
                                      onPress: () => {
                                            //BaseInheritedWidget.of(context)
                                            snackBar.showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text('${counter}'),
                                              ),
                                            ),
                                            setState(() {
                                              counter++;
                                            })
                                          },
                                      vertical: 20,
                                      horizontal: 40,
                                      width: 0.8),
                                )
                              ],
                            ),
                          );
                        }),
                  },
                  vertical: 20,
                  horizontal: 30,
                  width: 0.9,
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.6,
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 2,
                      children: List.generate(listServer.length, (index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: HexColor(kNormalBackground),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Center(
                            child: Text(
                              'Item ${listServer[index]}',
                              style: TextStyle(
                                  color: HexColor(kNormalString),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
        );
        // return Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: <Widget>[
        //     ListTile(
        //       leading: new Icon(Icons.photo),
        //       title: new Text('Photo'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     ListTile(
        //       leading: new Icon(Icons.music_note),
        //       title: new Text('Music'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     ListTile(
        //       leading: new Icon(Icons.videocam),
        //       title: new Text('Video'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     ListTile(
        //       leading: new Icon(Icons.share),
        //       title: new Text('Share'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ],
        // );
      },
    );
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('modal closed');
  }
}
