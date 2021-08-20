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

class AuthStateFailure extends AuthState {}

class AuthStateSuccess extends AuthState {
  final User user;
  const AuthStateSuccess({required this.user});
  @override
  String toString() => "auth : $user";
  @override
  // TODO: implement props
  List<Object> get props => [user];
  AuthStateSuccess cloneWith({required User user}) {
    return AuthStateSuccess(user: user);
  }
}
