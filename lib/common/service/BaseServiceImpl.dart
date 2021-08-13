/**
 * Copyright (C) 2021
 *
 * Description: The file class
 *
 * Change history:
 * Date             Defect#             Person             Comments
 * -------------------------------------------------------------------------------
 * August 4, 2021     ********           HoangNCM            Initialize
 *
 */


import 'package:gmc_erp/common/repository/BaseReposistory.dart';
import 'package:gmc_erp/common/service/BaseService.dart';

class BaseServiceImpl<TDto, TId> implements BaseService {

  final baseRep = BaseReposistory<TDto, TId>();

  @override
  Future<List<TDto>> getALl() {
    return baseRep.getALl();
  }

  @override
  Future<List> findById(id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future update(id, dto) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
