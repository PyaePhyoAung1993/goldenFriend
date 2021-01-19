import 'package:apiTesting/network/model/dateModel.dart';

class Repository {
  List<Map> getAll() => _nigeria;

  getLocalByState(String state) => _nigeria
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.state == state)
      .map((item) => item.lgas)
      .expand((i) => i)
      .toList();

  List<String> getState() => _nigeria
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.state)
      .toList();

  List _nigeria = [
    // {
    //   'state': 'daily',
    //   // 'alias': "one",
    //   'lgas': [
    //     'One',
    //     'Two',
    //     'Three',
    //   ]
    // },
    {
      'state': 'weekly',
      // 'alias': 'two',
      'lgas': [
        'FirstWeek',
        'SecondWeek',
        'ThirdWeek',
        'FourthWeek',
      ]
    },
    {
      'state': 'monthly',
      // 'alias': 'three',
      'lgas': [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ]
    },
  ];
}
