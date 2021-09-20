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

abstract class ProductOrderEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class getCountEvent extends ProductOrderEvent {
  final String type;
  getCountEvent({this.type});
}

class getPoOrderEvent extends ProductOrderEvent {
  final String type;
  final String statusType;
  getPoOrderEvent({this.type, this.statusType});
}

class getPoOrderDetailEvent extends ProductOrderEvent {
  final String type;
  final String no;
  getPoOrderDetailEvent({this.type, this.no});
}

class putPrDeatilEvent extends ProductOrderEvent {
  final int id;
  final dynamic detail;
  putPrDeatilEvent({this.id, this.detail});
}

class getNewPrScanEvent extends ProductOrderEvent {
  final String no;
  getNewPrScanEvent({ this.no});
}

class postNewPrEvent extends ProductOrderEvent {
  final String no;
  final dynamic detail;
  postNewPrEvent({ this.no, this.detail});
}