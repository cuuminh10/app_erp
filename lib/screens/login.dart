import 'package:gmc_erp/blocs/auth_bloc.dart';
import 'package:gmc_erp/events/auth_event.dart';
import 'package:gmc_erp/models/login.dart';
import 'package:gmc_erp/states/auth_states.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of(context);
    //  _authBloc!.add(LoginEvent(username: 'hoang'));
  }

  void handleLogin() {
    final username = usernameController.text;
    final password = passwordController.text;
    _authBloc.add(LoginEvent(username: username, password: password));
  }

  void getData(int n) {
    print(n * 2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSuccess) {
          final auth = state.props;
          print('day la ${auth}');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#4F5AC9'),
          title: Text('Sign In'),
        ),
        body: Container(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome to expert ERP 123',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: HexColor('#5B63CB'),
                        decoration: TextDecoration.underline),
                  )),
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 115,
                    width: 115,
                    child: Container(
                        child: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: const Text('AH'),
                    )),
                  )),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          hintText: 'Enter a search term'),
                    ),
                    SizedBox(height: 20),
                    Stack(
                      children: [
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              hintText: 'Enter a search term'),
                        ),
                        Positioned.fill(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: () => {},
                              icon: const Icon(Icons.visibility)),
                        ))
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: (FlatButton(
                          onPressed: () => {},
                          child: const Text(
                            " Forgot your password ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ))),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)))),
                            onPressed: () => {},
                            child: const Text("Sign in")))
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Welcome to expert ERP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: HexColor('#5B63CB'),
                            decoration: TextDecoration.underline),
                      ))),
            ],
          ),
        )),
      ),
    );
  }
}
