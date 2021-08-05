import 'package:gmc_erp/common/repository/BaseReposistory.dart';
import 'package:gmc_erp/common/service/BaseService.dart';

abstract class BaseServiceImpl<TDto, TId> implements BaseService {

  final baseRep = BaseReposistory<TDto, TId>();

  @override
  Future<List<TDto>> getALl() {

    throw UnimplementedError();
  }
}
