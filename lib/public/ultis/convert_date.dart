import 'package:intl/intl.dart';

class ConvertDate {

  static String ConvertDateTime (String dateString)  {
    var inputDate = DateTime.parse(dateString);
    String output = DateFormat('d/MM/yyyy').format(inputDate);
    return output;
  }
}