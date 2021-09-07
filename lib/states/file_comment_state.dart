import 'package:equatable/equatable.dart';
import 'package:gmc_erp/models/Comments.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/User.dart';
import 'package:gmc_erp/models/login.dart';

abstract class FileCommentState extends Equatable {
  const FileCommentState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FileCommentStateInitial extends FileCommentState {}

class FileCommentStateFailure extends FileCommentState {}


class FileCommentStateSuccess extends FileCommentState {
  final Comment comments;

  const FileCommentStateSuccess({required this.comments}) : assert(comments != null);

  @override
  String toString() => "comments : $comments";
  @override
  // TODO: implement props
  List<Object> get props => [comments];
  FileCommentStateSuccess cloneWith({required Comment comments}) {
    return FileCommentStateSuccess(comments: comments);
  }
}

class FileAttachStateSuccess extends FileCommentState {
  final Attach attach;

  const FileAttachStateSuccess({required this.attach}) : assert(attach != null);

  @override
  String toString() => "attach : $attach";
  @override
  // TODO: implement props
  List<Object> get props => [attach];
  FileAttachStateSuccess cloneWith({required Attach attach}) {
    return FileAttachStateSuccess(attach: attach);
  }
}

