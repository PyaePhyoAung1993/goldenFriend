import 'package:intl/intl.dart';

String appDateForm(DateTime date) {
  final f = new DateFormat('dd-MM-yyyy');
  // f.format(new DateTime.fromMicrosecondsSinceEpoch(date[index]["start_time"]*1000));
  // return DateFormat.yMd().format(date);
  return f.format(date);
}
