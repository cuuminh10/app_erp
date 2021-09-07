import 'package:gmc_erp/common/service/BaseServiceImpl.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/repository/FileCommentRepository.dart';
import 'package:gmc_erp/services/FileCommentService.dart';

class FileCommentServiceImpl extends BaseServiceImpl<Comment, int> implements FileCommentService {

  final repository = FileCommentRepository();

  @override
  Future<Comment> postComment(String type, String no, String content) {
    return repository.postComments(type, no, content);
  }

  @override
  Future<Attach> postAttach(String type, int objectId, String file) {
    return repository.postAttach(type, objectId, file);
  }
}