import 'package:gmc_erp/common/service/BaseServiceImpl.dart';
import 'package:gmc_erp/models/DTO/request_product_dto.dart';
import 'package:gmc_erp/models/DTO/response_product_dto.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:gmc_erp/repository/ProductOrderRepsitory.dart';
import 'package:gmc_erp/services/ProductOrderService.dart';
import 'package:gmc_erp/common/constants/Constants.dart';

class ProductOrderServiceImpl extends BaseServiceImpl<ProductOrderServiceImpl, int> implements ProductOrderService {

  final repository = ProductOrderRepsitory();

  @override
  Future<ProductOrderCount> getCount(String type) {
      return repository.getCount(type);
  }

  @override
  Future<List<ProductOrderOpen>> getListPoOrder(String type, String statusType) {
    String status = Constants.getQueryProductOrder(statusType);

    return repository.getListPoOrder(type, status);
  }

  @override
  Future<ProductOrderDetail> getDetail(String type, String no) {
    return repository.getDetail(type, no);
  }

  @override
  Future<String> putDetailPR(int id, detail) {
    return repository.putDetailPR(id, detail);
  }

  @override
  Future<ProductOrderDetail> getCreateScanPr(String no) {
    return repository.getCreateScanPr(no);
  }

  @override
  Future<String> postNewDetailPR(String no, detail) {
    return repository.postCreateScanPr(no, detail);
  }

  @override
  Future<List<ResponseProduct_1_DTO>> getProductGroup(RequestProductDTO requestProductDTO, String screenCode) {
    return repository.getProductGroup(requestProductDTO, screenCode);
  }

  @override
  Future<List<ProductOrderOpen>> getListPoOrderV2(RequestProductDTO requestProductDTO, String screenCode) {
    return repository.getListPoOrderV2(requestProductDTO, screenCode);
  }
}