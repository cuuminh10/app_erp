import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/events/auth_event.dart';
import 'package:gmc_erp/screens/login.dart';
import 'package:gmc_erp/screens/project_dashboard.dart';
import 'package:gmc_erp/screens/welcome.dart';
import 'package:gmc_erp/servicesImpl/CommentSerivceImpl.dart';

import 'blocs/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CommentServiceImpl>(
            create: (context) => CommentServiceImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            final commentSerive = RepositoryProvider.of<CommentServiceImpl>(context);
            return AuthBloc(commentSerive)..add(LoginEvent(username: 'hoang'));
          })
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
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
