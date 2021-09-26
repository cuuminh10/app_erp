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

import 'dart:convert';

import 'package:gmc_erp/models/DTO/request_product_dto.dart';
import 'package:gmc_erp/models/DTO/response_product_dto.dart';
import 'package:gmc_erp/models/ProductOrderCount.dart';
import 'package:gmc_erp/common/constants/Constants.dart';
import 'package:gmc_erp/models/ProductOrderDetail.dart';
import 'package:gmc_erp/models/ProductOrderOpen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductOrderRepsitory {
  http.Client httpClient = http.Client();

  Future<ProductOrderCount> getCount(String type) async {
    final url = "${Constants.apiBaseURL}/productOrder/groups/${type}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if (response.statusCode == 200) {
      return ProductOrderCount.fromJsonMap(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      var msg = json.decode(response.body);
      throw Exception(msg["message"]);
    }
  }

  Future<List<ProductOrderOpen>> getListPoOrder(
      String type, String statusType) async {
    final url = "${Constants.apiBaseURL}/productOrder/${type}/${statusType}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
    );

    if (response.statusCode == 200) {
      // return ProductOrderOpen.fromJsonMap(json.decode(response.body));
      final respondData = json.decode(response.body) as List;
      final List<ProductOrderOpen> listResult = respondData.map((comment) {
        return ProductOrderOpen.fromJsonMap(comment);
      }).toList();

      return listResult;
    } else {
      // If that call was not successful, throw an error.
      var msg = json.decode(response.body);
      throw Exception(msg["message"]);
    }
  }

  Future<ProductOrderDetail> getDetail(String type, String no) async {
    final url =
        "${Constants.apiBaseURL}/productOrder/detail/v2/${type}/${no.replaceAll(RegExp(r'/'), '%2F')}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}',
      },
    );

    if (response.statusCode == 200) {
      return ProductOrderDetail.fromJsonMap(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      var msg = json.decode(response.body);
      throw Exception(msg["message"]);
    }
  }

  Future<String> putDetailPR(int id, dynamic detail) async {
    var data = detail["detail"].map(
      (product) {
        return {
          'id': product.itemID,
          'qty': product.qty,
          'cancelQty': product.cancelQty,
          'setUpQty': product.setUpQty,
          'ncrQty': product.ncrQty,
        };
      },
    ).toList();

    final url = "${Constants.apiBaseURL}/productOrder/${id}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.put(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
        body: jsonEncode(<String, dynamic>{
          "description": detail["description"],
          "detail": data
        }));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      var msg = json.decode(response.body);
      throw Exception(msg["message"]);
    }
  }

  Future<ProductOrderDetail> getCreateScanPr(String no) async {
    final url = "${Constants.apiBaseURL}/productOrder/scanProdRstFromJT/${no.replaceAll(RegExp(r'/'), '%2F')}";;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.get(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        });

    if (response.statusCode == 200) {
      return ProductOrderDetail.fromJsonMap(json.decode(response.body));
    }else if (response.statusCode == 400) {
      throw Exception(response.body);
    }else {
      // If that call was not successful, throw an error.
      var msg = json.decode(response.body);
      throw Exception(msg["message"]);
    }
  }

  Future<String> postCreateScanPr(String no, dynamic detail) async {
    final url = "${Constants.apiBaseURL}/productOrder/createProdRst/${no.replaceAll(RegExp(r'/'), '%2F')}";;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
        body: jsonEncode(<String, dynamic>{
          "description": detail["description"],
          "detail": detail["detail"],
        }));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      var msg = json.decode(response.body);
      throw Exception(msg["message"]);
    }
  }

  Future<List<ResponseProduct_1_DTO>> getProductGroup(RequestProductDTO requestProductDTO, String screenCode) async {
    final url = "${Constants.apiBaseURL}/productOrder/groups/v2/${screenCode}";;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await httpClient.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${prefs.getString('token')}',
        },
        body: jsonEncode(requestProductDTO.toJson()));

    if (response.statusCode == 200) {
      final respondData = json.decode(response.body) as List;
      final List<ResponseProduct_1_DTO> listResult = respondData.map((comment) {
        return ResponseProduct_1_DTO.fromJsonMap(comment);
      }).toList();

      return listResult;
    } else {
      // If that call was not successful, throw an error.
      var msg = json.decode(response.body);
      throw Exception(msg["message"] ?? msg["error"]);
    }
  }
}
