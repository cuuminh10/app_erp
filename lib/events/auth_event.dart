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

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class LoginEvent extends AuthEvent {
  final String? username;
  LoginEvent({this.username});
}