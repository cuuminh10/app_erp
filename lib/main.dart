import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/blocs/product_order_bloc.dart';
import 'package:gmc_erp/screens/welcome.dart';
import 'package:gmc_erp/servicesImpl/AuthServiceImpl.dart';
import 'package:gmc_erp/servicesImpl/ProductOrderServiceImpl.dart';


import 'blocs/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthServiceImpl>(
            create: (context) => AuthServiceImpl()),
        RepositoryProvider<ProductOrderServiceImpl>(
            create: (context) => ProductOrderServiceImpl()),
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
    );
  }
}
