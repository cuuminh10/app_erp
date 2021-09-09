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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:gmc_erp/services/ProductOrderService.dart';
import 'package:gmc_erp/states/product_order_state.dart';

class ProductOrderBloc extends Bloc<ProductOrderEvent, ProductOrderState> {

  final ProductOrderService _productOrderService;

  //initial State
  ProductOrderBloc(ProductOrderService productOrderService)
      : assert(productOrderService != null),
        _productOrderService = productOrderService,
        super(ProductOrderInitial()){
  }

  @override
  Stream<ProductOrderState> mapEventToState(ProductOrderEvent event) async*{
    if (event is getCountEvent) {
      String type = event.type!;

      final result =  await _productOrderService.getCount(type);
      // Write value
      yield ProductOrderCountSuccess(productOrderCount: result);
      return;
    }

    if (event is getPoOrderEvent) {
      String type = event.type!;
      String statusType = event.statusType!;

      final result =  await _productOrderService.getListPoOrder(type, statusType);
      // Write value
      yield ProductOrderSuccess(productOrderOpen: result);
      return;
    }

    if (event is getPoOrderDetailEvent) {
      String type = event.type!;
      String no = event.no!;

      final result =  await _productOrderService.getDetail(type, no);
      // Write value
      yield ProductOrderDetailSuccess(productOrderDetail: result);
      return;
    }

    if (event is putPrDeatilEvent) {
      int id = event.id!;
      dynamic detail = event.detail;

      final result = await _productOrderService.putDetailPR(id, detail);
      // Write value
      yield ProductOrderPutDetailSuccess(id: result);
      return;
    }
  }
}