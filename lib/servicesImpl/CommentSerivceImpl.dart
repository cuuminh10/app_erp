import 'package:gmc_erp/models/Comment.dart';
import 'package:gmc_erp/repository/CommentRepository.dart';
import 'package:gmc_erp/services/CommentService.dart';

class CommentServiceImpl implements CommentService {

  final commentRepository = CommentRepository();

  @override
  Future<List<Comment>> getCommentFromApi() async {
    return commentRepository.getCommentFromApi();
  }

}