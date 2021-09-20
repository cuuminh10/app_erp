import 'package:equatable/equatable.dart';
import 'package:gmc_erp/models/Favor.dart';

abstract class FavorState extends Equatable {
  const FavorState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FavorInitial extends FavorState {}

class FavorFailure extends FavorState {}

class FavorSuccess extends FavorState {
  final List<Favor> favor;
  const FavorSuccess({this.favor});
  @override
  String toString() => "data : $favor";
  @override
  // TODO: implement props
  List<Object> get props => [favor];
  FavorSuccess cloneWith({List<Favor> favor}) {
    return FavorSuccess(favor: favor);
  }
}

class FavorPostSuccess extends FavorState {
  final Favor favor;
  const FavorPostSuccess({this.favor});
  @override
  String toString() => "data : $favor";
  @override
  // TODO: implement props
  List<Object> get props => [favor];
  FavorPostSuccess cloneWith({Favor favor}) {
    return FavorPostSuccess(favor: favor);
  }
}

class FavorDeleteSuccess extends FavorState {
  final int id;
  const FavorDeleteSuccess({this.id});
  @override
  String toString() => "data : $id";
  @override
  // TODO: implement props
  List<Object> get props => [id];
  FavorDeleteSuccess cloneWith({int id}) {
    return FavorDeleteSuccess(id: id);
  }
}
