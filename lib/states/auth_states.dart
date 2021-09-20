import 'package:equatable/equatable.dart';
import 'package:gmc_erp/models/User.dart';
import 'package:gmc_erp/models/login.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {}

class AuthStateFailure extends AuthState {
  final String errorMsg;
  final String date;
  const AuthStateFailure({this.errorMsg, this.date});
  @override
  String toString() => "auth : $errorMsg";
  @override
  // TODO: implement props
  List<Object> get props => [date];
  AuthStateFailure cloneWith({String errorMsg}) {
    return AuthStateFailure(errorMsg: errorMsg);
  }
}

class AuthStateSuccess extends AuthState {
  final User user;
  const AuthStateSuccess({this.user});
  @override
  String toString() => "auth : $user";
  @override
  // TODO: implement props
  List<Object> get props => [user];
  AuthStateSuccess cloneWith({User user}) {
    return AuthStateSuccess(user: user);
  }
}
