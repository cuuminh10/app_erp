import 'package:gmc_erp/common/service/BaseService.dart';
import 'package:gmc_erp/models/User.dart';

abstract class AuthService implements BaseService {

  /**
   * Login
   * @Param String: username
   * @Param String: password
   */
  Future<User> login(String username, String password);

}