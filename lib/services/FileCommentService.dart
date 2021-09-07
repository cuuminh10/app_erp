import 'package:gmc_erp/common/service/BaseService.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';

abstract class FileCommentService implements BaseService {

  /**
   * get count
   * @Param String: type
   */
  Future<Comment> postComment(String type, String no, String content);

  /**
   * get count
   * @Param String: type
   */
  Future<Attach> postAttach(String type, int objectId, String file);
}