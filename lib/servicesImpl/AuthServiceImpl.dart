import 'package:gmc_erp/common/service/BaseServiceImpl.dart';
import 'package:gmc_erp/models/User.dart';
import 'package:gmc_erp/repository/AuthRepository.dart';
import 'package:gmc_erp/services/AuthService.dart';

class AuthServiceImpl extends BaseServiceImpl<AuthServiceImpl, int> implements AuthService {

  final authRepository = AuthRepository();
  /**
   * Login
   * @Param String: username
   * @Param String: password
   */
  @override
  Future<User> login(String username, String password) {
    return authRepository.login(username, password);
  }
}