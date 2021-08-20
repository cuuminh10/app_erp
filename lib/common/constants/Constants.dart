import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String apiBaseURL = 'http://175.41.183.152:8080';

  static const String DATE_FORMAT = 'dd/MM/yyyy';
  static const String TIME_FORMAT = 'HH:mm';

  static const String Open = 'Open';
  static const String Overdue = 'Overdue';
  static const String Incomplete = 'Incomplete';
  static const String Complete = 'Complete';

  static const String New  = 'New';
  static const String Transfered = 'Transfered';
  static const String Transfering = 'Transfering';

  static String getQueryProductOrder(String type)  {
    switch(type){
      case Open:
        return New;
      case Overdue:
        return Transfered;
      case Incomplete:
        return Transfering;
      default:
        return Overdue;
    }
  }
}