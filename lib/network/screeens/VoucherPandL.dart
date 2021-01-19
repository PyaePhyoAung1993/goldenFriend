import 'dart:convert';

import 'package:apiTesting/network/model/dateFormat.dart';
import 'package:apiTesting/network/model/repository.dart';
import 'package:apiTesting/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoucherPAndL extends StatefulWidget {
  String token;

  DateTime selectedDate;

  VoucherPAndL({Key key, @required this.token}) : super(key: key);
  @override
  _VoucherPAndLState createState() => _VoucherPAndLState();
}

class _VoucherPAndLState extends State<VoucherPAndL> {
  // final List<String> _items = ['Day', 'Week', 'Month'].toList();

  var api = 'https://goldenfriends.kwintechnologies.com/api/profit';
  var res;
  var drinks = null;

  String branch_id = '1';

  String type = "";

  String week_count;
  String month_count;

  Repository repo = Repository();

  String type_detail = "";
  String type_detail_name = "";

  List<String> _states = ["Choose a state"];
  List<String> _lgas = ["Choose a lga"];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose a lga";

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getState());
    super.initState();
  }

  fetch1(String name, String name1, String name2) async {
    res = await http.post(api, headers: {
      "Accept": 'application.json',
      'Authorization': "Bearer ${widget.token}"
    }, body: {
      "type": name,
      name1: name2,
      "branch_id": branch_id
    });

    drinks = jsonDecode(res.body);
    print('Response data1 $drinks');
    print(drinks.toString());
    setState(() {});
  }

  fetchData() async {
    if (type == "weekly") {
      type_detail_name = "week_count";
      type_detail = week_count;
      print(type_detail_name);
    } else {
      type_detail_name = "month";
      type_detail = month_count;
    }

    // print("Type Date Testing : $type_detail");
    // if (type == 'weekly') {
    //   type_detail_name = "week_count";
    //   type_detail = week_count;
    // } else {
    //   type_detail_name = "month";
    //   type_detail = month_count;
    // }
    res = await http.post(api, headers: {
      "Accept": 'application.json',
      'Authorization': "Bearer ${widget.token}"
    }, body: {
      "type": type,
      type_detail_name: type_detail,
      "branch_id": branch_id
    });

    drinks = jsonDecode(res.body);
    print('Response data $drinks');
    print(drinks.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final dropdownMenuOptions = _items
    //     .map((String item) =>
    //         new DropdownMenuItem<String>(value: item, child: new Text(item)))
    //     .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Golden Friends"),
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Golden Friends Liquor Store",
                  style: texteditLogin,
                ),
                Text(
                  "Financial Report",
                  style: texteditLogin,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Padding(padding: EdgeInsets.only(left: 16)),
                            Text(
                              widget.selectedDate != null
                                  ? appDateForm(widget.selectedDate)
                                  : "selecte date",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.today,
                                  color: Colors.green,
                                ),
                              ),
                              onTap: _pickDOB,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.search),
                          color: Colors.green,
                          onPressed: () {
                            setState(() {
                              type = 'daily';
                              // type_detail_name = 'date';
                              var date = widget.selectedDate.toString();
                              fetch1('$type', 'date', '$date');
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  margin: EdgeInsets.only(
                    top: 15,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton<String>(
                        // isExpanded: true,
                        items: _states.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (value) => _onSelectedState(value),
                        value: _selectedState,
                      ),
                      DropdownButton<String>(
                        // isExpanded: true,
                        items: _lgas.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        // onChanged: (value) => print(value),
                        onChanged: (value) => _onSelectedLGA(value),
                        value: _selectedLGA,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            // size: 30,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              fetchData();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 180),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Widget cardrevenue = _card();
                //cardrevenue.setstate();
                //Widget cardprofit = _card();
                //cardprofit = _card();
                _cardRevenue("daily ", 'Revenue', 0),
                _cardProfit("daily ", 'Profit', 0),
                _cardExpense("daily ", 'Expense', 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _pickDOB() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    print("Date :  $pickedDate");
    setState(() {
      widget.selectedDate = pickedDate;
    });
  }

  Widget _cardRevenue(String name, String name1, int value) {
    setState(() {
      name = type;
      if (drinks != null) {
        value = drinks['total_sales'];
      } else {
        value = 0;
      }
      //drink['net_profit']
      //drink['total_expenses']
    });
    return Card(
      // color: Colors.greenAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // margin: EdgeInsets.only(top: 200),
      margin: EdgeInsets.only(left: 20, right: 20),

      child: Container(
        margin: EdgeInsets.only(left: 10),
        width: 240,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$name",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$name1",
              style: TextStyle(
                color: Colors.green,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$value",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardProfit(String name, String name1, int value) {
    setState(() {
      name = type;
      if (drinks != null) {
        value = drinks['net_profit'];
      } else {
        value = 0;
      }
    });
    return Card(
      // color: Colors.greenAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // margin: EdgeInsets.only(top: 200),
      margin: EdgeInsets.only(left: 20, right: 20),

      child: Container(
        margin: EdgeInsets.only(left: 10),
        width: 240,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$name",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$name1",
              style: TextStyle(
                color: Colors.green,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$value",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardExpense(String name, String name1, int value) {
    setState(() {
      name = type;
      if (drinks != null) {
        value = drinks['total_expenses'];
      } else {
        value = 0;
      }
    });
    return Card(
      // color: Colors.greenAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      // margin: EdgeInsets.only(top: 200),
      margin: EdgeInsets.only(left: 20, right: 20),

      child: Container(
        margin: EdgeInsets.only(left: 10),
        width: 240,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$name",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$name1",
              style: TextStyle(
                color: Colors.green,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$value",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectedState(String value) {
    setState(() {
      type = value;
      _selectedLGA = "Choose ..";
      _lgas = ["Choose .."];
      _selectedState = value;
      _lgas = List.from(_lgas)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() {
      _selectedLGA = value;
    });

    /*if(type=="weekly"{
      if(value==firstweek){
        week_count=1
      }else if(value==secondweek{
        week_count=2
      }
    }else if(type=="monthly"){
      if(value=="January"){
        month==01;
      }
    }*/

    if (type == "weekly") {
      if (value == "FirstWeek") {
        week_count = '1';
      } else if (value == "SecondWeek") {
        week_count = '2';
      } else if (value == "ThirdWeek") {
        week_count = '3';
      } else if (value == "FourthWeek") {
        week_count = '4';
      } else {}

      //print(month_count);
    } else if (type == "monthly") {
      if (value == "January") {
        month_count = '01';
      } else if (value == 'February') {
        month_count = '02';
        //print(month_count);
      } else if (value == 'March') {
        month_count = '03';
      } else if (value == 'April') {
        month_count = '04';
        //print(month_count);
      } else if (value == 'May') {
        month_count = '05';
      } else if (value == 'June') {
        month_count = '06';
      } else if (value == 'July') {
        month_count = '07';
        // print(month_count);
      } else if (value == 'August') {
        month_count = '08';
      } else if (value == 'September') {
        month_count = '09';
      } else if (value == 'October') {
        month_count = '10';
      } else if (value == 'November') {
        month_count = "11";
      } else if (value == 'December') {
        month_count = "12";
      } else {}

      // setState(() => _selectedLGA = week_count);

    } else {}
    print(week_count);
    print(month_count);

    // void search (String value) {
    //   if(_selectedState == value &&  _selectedLGA == value){
    //     return
    //   }

    // }
  }
//    _pickDOB() async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     setState(() {
//       widget.selectedDate = pickedDate;
//     });
//   }
// }

}
