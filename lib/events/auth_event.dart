import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/editable_text.dart';

abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class LoginEvent extends AuthEvent {
  final String? username;
  LoginEvent({this.username});
}