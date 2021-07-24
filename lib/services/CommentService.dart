import 'package:gmc_erp/models/Comment.dart';

abstract class CommentService {
  Future<List<Comment>> getCommentFromApi();
}