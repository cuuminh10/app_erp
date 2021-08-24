/**
 * Copyright (C) 2021
 *
 * Description: The file class
 *
 * Change history:
 * Date             Defect#             Person             Comments
 * -------------------------------------------------------------------------------
 * August 4, 2021     ********           HoangNCM            Initialize
 *
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/events/auth_event.dart';
import 'package:gmc_erp/services/AuthService.dart';
import 'package:gmc_erp/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthService _authService;

  //initial State
  AuthBloc(AuthService authService)
      : assert(authService != null),
        _authService = authService,
        super(AuthStateInitial()){
  }


  // @override
  // AuthState get initialState {
  //   print("vao override initial");
  //   return AuthStateInitial();
  // }


  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if (event is LoginEvent) {
     // _commentService.getCommentFromApi();
      //_authService.getALl();
      String username = event.username!;
      String password = event.password!;

      final user =  await _authService.login(username, password);
      // Write value
      yield AuthStateSuccess(user: user);
      return;
    }
  }
}