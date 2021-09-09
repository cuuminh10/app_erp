import 'package:gmc_erp/common/service/BaseService.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:gmc_erp/models/User.dart';

abstract class ProductOrderService implements BaseService {

  /**
   * get count
   * @Param String: type
   */
  Future<ProductOrderCount> getCount(String type);

  /**
   * get count
   * @Param String: type
   */
  Future<List<ProductOrderOpen>> getListPoOrder(String type, String statusType);

  /**
   * get count
   * @Param String: type
   */
  Future<ProductOrderDetail> getDetail(String type, String no);

  /**
   * get count
   * @Param String: type
   */
  Future<String> putDetailPR(int id, dynamic detail);

  /**
   * get count
   * @Param String: type
   */
  Future<ProductOrderDetail> getCreateScanPr(String no);
}