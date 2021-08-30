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

abstract class FileCommentEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class postComment extends FileCommentEvent {
  final String type;
  final String no;
  final String content;
  postComment({required this.type, required this.no, required this.content});
}
