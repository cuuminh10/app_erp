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
import 'package:gmc_erp/common/service/BaseService.dart';
import 'package:gmc_erp/events/auth_event.dart';
import 'package:gmc_erp/models/login.dart';
import 'package:gmc_erp/services/CommentService.dart';
import 'package:gmc_erp/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final CommentService _commentService;

  //initial State
  AuthBloc(CommentService commentService)
      : assert(commentService != null),
        _commentService = commentService,
        super(AuthStateInitial()){
    print("vao initial");
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
      _commentService.getALl();
      yield AuthStateSuccess(auth: new Auth('Hoang', '123'));
      return;
    }
  }
}