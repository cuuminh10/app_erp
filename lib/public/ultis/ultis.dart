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
        data['label_topLeft'] = 'Phase';
        data['label_topRight'] = 'Work Center';
        data['label_bottomLeft'] = 'Pic By';
        data['label_bottomRight'] = 'Due Date';
        break;
      case ProductionFG:
        data['name'] = 'Production Result';
        data['code'] = 'producResult';
        data['label_topLeft'] = 'Phase';
        data['label_topRight'] = 'Work Center';
        data['label_bottomLeft'] = 'Pic By';
        data['label_bottomRight'] = 'Due Date';
        break;
    }

    return data;
  }

  static String cutName(String name) {
    if (name.isNotEmpty &&  name.split(" ").length > 0) {
       var nameArr = name.split(" ");
       String nameCut = nameArr[0].substring(0,1) + (nameArr[nameArr.length - 1].substring(0,1));
       return nameCut;
    }
    return name.isNotEmpty ? name.substring(0,1) : name;
  }
}
