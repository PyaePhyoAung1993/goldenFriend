import 'dart:convert';
import 'package:apiTesting/network/model/dateFormat.dart';
import 'package:apiTesting/network/screeens/VoucherDetail.dart';
import 'package:apiTesting/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoucherAll extends StatefulWidget {
  String token;

  DateTime selectedDate;
  DateTime selectedDate1;

  DateTime curentDate = DateTime.now();

  VoucherAll({Key key, @required this.token}) : super(key: key);
  @override
  _VoucherAllState createState() => _VoucherAllState();
}

class _VoucherAllState extends State<VoucherAll> {
  var api = 'https://goldenfriends.kwintechnologies.com/api/voucher_all';
  var res, drinks;

  int index;

  var message;

  String from = '07-09-2020';

  String to = '21-09-2020';

  String auth =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjFmZjVlOTQ4YmNmYzdjNzI2YmQzZGFiNDViMWFiMmMxZjEyYmQxYzQxODNkODFhNWRiZjgyY2RlNmRkYWRlZWFiOWVmM2RiY2I5NWM0NjkiLCJpYXQiOjE2MDI5MTYyODAsIm5iZiI6MTYwMjkxNjI4MCwiZXhwIjoxNjM0NDUyMjgwLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.D1HunKMd__aWXjlmokEMopxxhc0SdWtP-sI8AKXMybdWBNb6e6Zt1zJpafQ4Zrbj4O3n2Pq5LUGW-14qjz7_GQCmTP0TywCl9olTZKphJpvb-zgJZkY-BJ3pwhB1bwhmcaAi34rPYgK-x8XRWTFguvT0r9HjETNvqPLCTXGm7e2QAhhFbpUdpN_-kQWPakyqZsyNTCg83foIHtmeX0wuL82BctLlwxKt-g2dD-hN98MJLEqYa0lFaOOVK3Hp115uMnB16B7UT0UcSYgeWRfPzNHAKovRb-UCtidqs0QxAPvWjTXbiIpMAnIa8pWNza6y32srgluL_wuOKiFUqPh2P2eeNcCkrrDEJQ_bLUGj6rrKCf4XINdgn7U_O1wSqt_uFg-AbK1f04lxk5Hiy1aRZQH0IMM39T0NDAA1PTQHbcYucdk_Iy-aVlQwhtwiybkKV025r0wHYjxOKXIjI0dlOEZLli6Qn52Q7cyQ846VSsahr_xcT1i1t4N90dYuK4jIU-tPlFrGqAy210q3p2h0bFE37f3zJvhOavGoyHdxTyBMczZhBWjyoZDzXmea2pW-VnDbCZFl5nx0alf2laZpO0RFRRHhpwgRZAhqCiwPE3UFQYEX2Sh6ieXCIDopbzv808haeVDG9_SlOG4IN1HmF9gZ9-zGiOEU9d7v2f3Q6mY";

  // saveToken() {
  //   final token = Provider.of<FutureObject>(context, listen: false);
  //   var to = token.getStringValuesSF();
  //   return to;
  // }

  @override
  void initState() {
    super.initState();
  }

  fetchData() async {
    res = await http.post(api, headers: {
      "Accept": 'application/json',
      'Authorization': "Bearer ${widget.token}"
    }, body: {
      "from": '${widget.selectedDate}',
      'to': '${widget.selectedDate1}'
    });

    if (res == null) {
      message = "No data";
    } else if (widget.selectedDate.isAfter(widget.curentDate) &&
        widget.selectedDate1.isAfter(widget.curentDate)) {
      message = "Missing Date";
    } else {
      drinks = jsonDecode(res.body)['items'];
    }

    drinks = jsonDecode(res.body)['Voucher_all'];
    print('Response data $drinks');
    print(drinks.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voucher All"),
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
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
                  height: 40,
                ),
                Container(
                  // padding: EdgeInsets.all(8.0),

                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 130,
                        margin: EdgeInsets.only(left: 7),
                        // color: Colors.white,
                        // padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            // Padding(padding: EdgeInsets.only(left: 16.0)),
                            Text(
                              widget.selectedDate != null
                                  ? appDateForm(widget.selectedDate)
                                  : "from",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 10,
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
                        width: 130,
                        margin: EdgeInsets.only(left: 7),
                        // color: Colors.white,
                        // padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            // Padding(padding: EdgeInsets.only(left: 16.0)),
                            Text(
                              widget.selectedDate1 != null
                                  ? appDateForm(widget.selectedDate1)
                                  : "to",
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.today,
                                  color: Colors.green,
                                ),
                              ),
                              onTap: _pickDOB1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
                            fetchData();
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
            margin: EdgeInsets.only(top: 170),
            child: res != null
                ? ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (context, index) {
                      var drink = drinks[index];
                      int id = drink['id'];

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 20, top: 10),
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 6.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Golden Friends",
                                  style: textEdit1,
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Text(
                                  "Voucher\ncode: ${drink["voucher_code"]}",
                                  style: textEditStyle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Total:${drink["total_price"]}",
                                    style: textEdit1),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Qty : ${drink["total_quantity"]}",
                                  style: textEdit1,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ButtonTheme(
                                  minWidth: 80,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.green)),
                                    color: Colors.white,
                                    onPressed: () {
                                      // fetchAlbum(userCodeController.text, mailController.text,
                                      //     passwordController.text);
                                      print(id);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) => VoucherDetail(
                                                    data: drink,
                                                    token: widget.token,
                                                  )));
                                      // setState(() {
                                      //   futureAuthModel = fetchAlbum(userCodeController.text,
                                      //       mailController.text, passwordController.text);
                                      // });
                                    },
                                    child: Text(
                                      "Detail",
                                      style: texteditLogin2,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
                : Text(" "),
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
    setState(() {
      widget.selectedDate = pickedDate;
    });
  }

  _pickDOB1() async {
    final pickedDate1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    setState(() {
      widget.selectedDate1 = pickedDate1;
    });
  }
}

const textedit = TextStyle(
  fontSize: 20,
);

const textEdit1 = TextStyle(
  fontSize: 15,
);

const textEdit2 = TextStyle(
  fontSize: 15,
  color: Colors.white,
);
