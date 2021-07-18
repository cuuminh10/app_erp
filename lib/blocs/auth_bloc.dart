import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/events/auth_event.dart';
import 'package:gmc_erp/events/comment_event.dart';
import 'package:gmc_erp/models/login.dart';
import 'package:gmc_erp/states/Comment_states.dart';
import 'package:gmc_erp/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //initial State
  AuthBloc():super(AuthStateInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if (event is LoginEvent) {
      print(event.username);
      yield AuthStateSuccess(auth: new Auth('Hoang', '123'));
      return;
    }
  }
}