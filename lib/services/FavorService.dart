import 'package:gmc_erp/common/service/BaseService.dart';
import 'package:gmc_erp/models/Favor.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:gmc_erp/models/User.dart';

abstract class FavorService implements BaseService {

  /**
   * get count
   * @Param String: type
   */
  Future<List<Favor>> getFavor();

  /**
   * get count
   * @Param String: type
   */
  Future<Favor> postFavor(String moduleName);

  /**
   * get count
   * @Param String: type
   */
  Future<int> deleteFavor(int id);

}