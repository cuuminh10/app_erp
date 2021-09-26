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


class ReponseProductDTO {

  List<ResponseProduct_1_DTO> listProduct;

  ReponseProductDTO(this.listProduct);

  ReponseProductDTO.fromJsonMap(Map<String, dynamic> map):
        listProduct = List<ResponseProduct_1_DTO>.from(
            map["detail"].map((x) => ResponseProduct_1_DTO.fromJsonMap(x)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listProduct'] = listProduct;
    return data;
  }
}

class ResponseProduct_1_DTO {
  int counts;
  String name;


  ResponseProduct_1_DTO(this.counts, this.name);

  ResponseProduct_1_DTO.fromJsonMap(Map<String, dynamic> map):
        counts = map["counts"],
        name = map["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counts'] = counts;
    data['name'] = name;
    return data;
  }
}