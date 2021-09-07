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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmc_erp/events/file_comment_event.dart';
import 'package:gmc_erp/events/product_order_event.dart';
import 'package:gmc_erp/services/FileCommentService.dart';
import 'package:gmc_erp/services/ProductOrderService.dart';
import 'package:gmc_erp/states/file_comment_state.dart';
import 'package:gmc_erp/states/product_order_state.dart';

class FileCommentBloc extends Bloc<FileCommentEvent, FileCommentState> {

  final FileCommentService _fileCommentService;

  //initial State
  FileCommentBloc(FileCommentService fileCommentService)
      : assert(fileCommentService != null),
        _fileCommentService = fileCommentService,
        super(FileCommentStateInitial()){
  }

  @override
  Stream<FileCommentState> mapEventToState(FileCommentEvent event) async*{
    if (event is postComment) {
      String type = event.type;
      String no = event.no;
      String content = event.content;

      final result =  await _fileCommentService.postComment(type, no, content);

      yield FileCommentStateSuccess(comments: result);
      return;
    }

    if (event is postAttach) {
      String type = event.type;
      int objectId = event.objectId;
      String file = event.file;

      final result =  await _fileCommentService.postAttach(type, objectId, file);

      yield FileAttachStateSuccess(attach: result);
      return;
    }
  }
}