import 'package:flutter/material.dart';
import 'package:gmc_erp/public/enum/screens_enum.dart';

class Ultis {
  static const String ProductionOrdr = 'ProductionOrdr';
  static const String ProductionFG = 'ProductionFG';

  static bool isImages(String fileName) {
    return fileName.contains('.jpg');
  }

  static String isFile(String fileName) {
    return fileName.contains('.xlsm')
        ? "assets/images/xlsx.svg"
        : "assets/images/docs.svg";
  }

  static dynamic infoScreenProduct() {
    var data = {'name': '', 'code': ''};

    return {
      data['name'] = 'Production Result',
      data['code'] = 'producResult',
      data['label_topLeft'] = 'Result code',
      data['label_topRight'] = 'Job Ticket',
      data['label_bottomLeft'] = 'Date',
      data['label_bottomRight'] = 'Work Order',
    };
  }

  static dynamic filterScreensGMC(String codeScreen) {
    var data = {'name': '', 'code': ''};

    switch (codeScreen) {
      case ProductionOrdr:
        data['name'] = 'Job Ticket';
        data['code'] = 'jobticket';
        data['label_topLeft'] = 'Job Ticket';
        data['label_topRight'] = 'Work Order';
        data['label_bottomLeft'] = 'Date';
        data['label_bottomRight'] = 'PIC';
        break;
      case ProductionFG:
        data['name'] = 'Production Result';
        data['code'] = 'producResult';
        data['label_topLeft'] = 'Result code';
        data['label_topRight'] = 'Job Ticket';
        data['label_bottomLeft'] = 'Date';
        data['label_bottomRight'] = 'Work Order';
        break;
    }

    return data;
  }
}
