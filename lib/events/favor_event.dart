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

abstract class FavorEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class getFavorEvent extends FavorEvent {
  getFavorEvent();
}

class postFavorEvent extends FavorEvent {
  final String moduleName;
  postFavorEvent({this.moduleName});
}

class deleteFavorEvent extends FavorEvent {
  final int id;
  deleteFavorEvent({this.id});
}