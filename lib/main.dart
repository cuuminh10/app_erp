import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/blocs/favor_bloc.dart';
import 'package:gmc_erp/blocs/file_comment_bloc.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/common/widget/BaseInheritWidget.dart';
import 'package:gmc_erp/events/favor_event.dart';
import 'package:gmc_erp/screens/welcome.dart';
import 'package:gmc_erp/servicesImpl/AuthServiceImpl.dart';
import 'package:gmc_erp/servicesImpl/FavorServiceImpl.dart';
import 'package:gmc_erp/servicesImpl/FileCommentSerivceImpl.dart';
import 'package:gmc_erp/servicesImpl/ProductOrderServiceImpl.dart';


import 'blocs/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  dynamic infoScreen = null;

  void setInfoScreen(value) {
    setState(() {
      infoScreen = value;
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BaseInheritedWidget(
      infoScreen: infoScreen,
      state: this,
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthServiceImpl>(
              create: (context) => AuthServiceImpl()),
          RepositoryProvider<ProductOrderServiceImpl>(
              create: (context) => ProductOrderServiceImpl()),
          RepositoryProvider<FavorServiceImpl>(
              create: (context) => FavorServiceImpl()),
          RepositoryProvider<FileCommentServiceImpl>(
              create: (context) => FileCommentServiceImpl()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) {
              final service = RepositoryProvider.of<AuthServiceImpl>(context);
             // return AuthBloc(authService)..add(LoginEvent(username: 'hoang'));
              return AuthBloc(service);
            }),
            BlocProvider(create: (context) {
              final service = RepositoryProvider.of<ProductOrderServiceImpl>(context);
              return ProductOrderBloc(service);
            }),
            BlocProvider(create: (context) {
              final service = RepositoryProvider.of<FavorServiceImpl>(context);
              return FavorBloc(service)..add(getFavorEvent());
            }),
            BlocProvider(create: (context) {
              final service = RepositoryProvider.of<FileCommentServiceImpl>(context);
              return FileCommentBloc(service);
            })
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                primaryColor: Colors.white
            ),
            routes: <String, WidgetBuilder>{
              '/signin': (context) => WelcomeScreen()
            },
            home: WelcomeScreen(),
          ),
        ),
      ),
    );
  }
}
