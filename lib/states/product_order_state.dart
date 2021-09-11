import 'package:equatable/equatable.dart';
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
  const ProductOrderCountSuccess({required this.productOrderCount});
  @override
  String toString() => "data : $productOrderCount";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderCount];
  ProductOrderCountSuccess cloneWith({required ProductOrderCount productOrderCount}) {
    return ProductOrderCountSuccess(productOrderCount: productOrderCount);
  }
}

class ProductOrderSuccess extends ProductOrderState {
  final List<ProductOrderOpen> productOrderOpen;
  const ProductOrderSuccess({required this.productOrderOpen});
  @override
  String toString() => "data : $productOrderOpen";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderOpen];
  ProductOrderSuccess cloneWith({required List<ProductOrderOpen> productOrderOpen}) {
    return ProductOrderSuccess(productOrderOpen: productOrderOpen);
  }
}

class ProductOrderDetailSuccess extends ProductOrderState {
  final ProductOrderDetail productOrderDetail;

  ProductOrderDetailSuccess({required this.productOrderDetail}) : assert (productOrderDetail != null);

  @override
  String toString() => "data : $productOrderDetail";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderDetail];
  ProductOrderDetailSuccess cloneWith({required ProductOrderDetail productOrderOpen}) {
    return ProductOrderDetailSuccess(productOrderDetail: productOrderOpen);
  }
}

class ProductOrderPutDetailSuccess extends ProductOrderState {
  final String id;

  ProductOrderPutDetailSuccess({required this.id}) : assert (id != null);

  @override
  String toString() => "data : $id";
  @override
  // TODO: implement props
  List<Object> get props => [id];
  ProductOrderPutDetailSuccess cloneWith({required String id}) {
    return ProductOrderPutDetailSuccess(id: id);
  }
}

class ProductOrderCreateSuccess extends ProductOrderState {
  final  ProductOrderDetail productOrderDetail;

  ProductOrderCreateSuccess({required this.productOrderDetail}) : assert (productOrderDetail != null);

  @override
  String toString() => "data : $productOrderDetail";
  @override
  // TODO: implement props
  List<Object> get props => [productOrderDetail];
  ProductOrderCreateSuccess cloneWith({required ProductOrderDetail productOrderDetail}) {
    return ProductOrderCreateSuccess(productOrderDetail: productOrderDetail);
  }
}

class ProductOrderCreateFailer extends ProductOrderState {
  final  dynamic error;

  ProductOrderCreateFailer({required this.error}) : assert (error != null);

  @override
  String toString() => "data : $error";
  @override
  // TODO: implement props
  List<Object> get props => [error];
  ProductOrderCreateFailer cloneWith({required dynamic error}) {
    return ProductOrderCreateFailer(error: error);
  }
}

class ProductOrderPostSuccess extends ProductOrderState {
  final  String id;

  ProductOrderPostSuccess({required this.id}) : assert (id != null);

  @override
  String toString() => "data : $id";
  @override
  // TODO: implement props
  List<Object> get props => [id];
  ProductOrderPostSuccess cloneWith({required String id}) {
    return ProductOrderPostSuccess(id: id);
  }
}