import 'package:equatable/equatable.dart';
import 'package:gmc_erp/models/login.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {}

class AuthStateFailure extends AuthState {}

class AuthStateSuccess extends AuthState {
  final Auth auth;
  const AuthStateSuccess({required this.auth});
  @override
  String toString() => "auth : $auth";
  @override
  // TODO: implement props
  List<Object> get props => [auth];
  AuthStateSuccess cloneWith({required Auth auth}) {
    return AuthStateSuccess(auth: auth);
  }
}
