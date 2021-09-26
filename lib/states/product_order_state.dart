import 'package:equatable/equatable.dart';
import 'package:gmc_erp/models/DTO/response_product_dto.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:gmc_erp/models/User.dart';
import 'package:gmc_erp/models/login.dart';

abstract class ProductOrderState extends Equatable {
  const ProductOrderState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ProductOrderInitial extends ProductOrderState {}

class ProductOrderFailure extends ProductOrderState {}

class ProductOrderCountSuccess extends ProductOrderState {
  final ProductOrderCount productOrderCount;
  const ProductOrderCountSuccess({ this.productOrderCount});
  @override
  String toString() => "data : $productOrderCount";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderCount];
  ProductOrderCountSuccess cloneWith({ ProductOrderCount productOrderCount}) {
    return ProductOrderCountSuccess(productOrderCount: productOrderCount);
  }
}

class ProductOrderSuccess extends ProductOrderState {
  final List<ProductOrderOpen> productOrderOpen;
  const ProductOrderSuccess({ this.productOrderOpen});
  @override
  String toString() => "data : $productOrderOpen";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderOpen];
  ProductOrderSuccess cloneWith({ List<ProductOrderOpen> productOrderOpen}) {
    return ProductOrderSuccess(productOrderOpen: productOrderOpen);
  }
}

class ProductOrderDetailSuccess extends ProductOrderState {
  final ProductOrderDetail productOrderDetail;

  ProductOrderDetailSuccess({ this.productOrderDetail}) : assert (productOrderDetail != null);

  @override
  String toString() => "data : $productOrderDetail";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderDetail];
  ProductOrderDetailSuccess cloneWith({ ProductOrderDetail productOrderOpen}) {
    return ProductOrderDetailSuccess(productOrderDetail: productOrderOpen);
  }
}

class ProductOrderPutDetailSuccess extends ProductOrderState {
  final String id;

  ProductOrderPutDetailSuccess({ this.id}) : assert (id != null);

  @override
  String toString() => "data : $id";
  @override
  // TODO: implement props
  List<Object> get props => [id];
  ProductOrderPutDetailSuccess cloneWith({ String id}) {
    return ProductOrderPutDetailSuccess(id: id);
  }
}

class ProductOrderCreateSuccess extends ProductOrderState {
  final  ProductOrderDetail productOrderDetail;

  ProductOrderCreateSuccess({ this.productOrderDetail}) : assert (productOrderDetail != null);

  @override
  String toString() => "data : $productOrderDetail";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderDetail];
  ProductOrderCreateSuccess cloneWith({ ProductOrderDetail productOrderDetail}) {
    return ProductOrderCreateSuccess(productOrderDetail: productOrderDetail);
  }
}

class ProductOrderFailer extends ProductOrderState {
  final  dynamic error;
  final String date;

  ProductOrderFailer({ this.error, this.date}) : assert (error != null);

  @override
  String toString() => "data : $error";
  @override
  // TODO: implement props
  List<Object> get props => [date];
  ProductOrderFailer cloneWith({ dynamic error}) {
    return ProductOrderFailer(error: error);
  }
}

class ProductOrderPostSuccess extends ProductOrderState {
  final  String id;

  ProductOrderPostSuccess({ this.id}) : assert (id != null);

  @override
  String toString() => "data : $id";
  @override
  // TODO: implement props
  List<Object> get props => [id];
  ProductOrderPostSuccess cloneWith({ String id}) {
    return ProductOrderPostSuccess(id: id);
  }
}

class getProductGroupSuccess extends ProductOrderState {
  final  List<ResponseProduct_1_DTO> list;

  getProductGroupSuccess({ this.list}) : assert (list != null);

  @override
  String toString() => "data : $list";
  @override
  // TODO: implement props
  List<Object> get props => [list];
  getProductGroupSuccess cloneWith({ List<ResponseProduct_1_DTO> list}) {
    return getProductGroupSuccess(list: list);
  }
}