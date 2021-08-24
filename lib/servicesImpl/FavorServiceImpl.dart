import 'package:gmc_erp/common/service/BaseServiceImpl.dart';
import 'package:gmc_erp/models/Favor.dart';
import 'package:gmc_erp/repository/FavorRepsitory.dart';
import 'package:gmc_erp/services/FavorService.dart';


class FavorServiceImpl extends BaseServiceImpl<FavorServiceImpl, int> implements FavorService {

  final repository = FavorRepsitory();

  @override
  Future<List<Favor>> getFavor() {
      return repository.getFavor();
  }

  @override
  Future<Favor> postFavor(String moduleName) {
    // TODO: implement getListPoOrder
    return repository.postFavor(moduleName);
  }

  @override
  Future<int> deleteFavor(int id) {
   return repository.deleteFavor(id);
  }


}