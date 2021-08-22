import 'package:equatable/equatable.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
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