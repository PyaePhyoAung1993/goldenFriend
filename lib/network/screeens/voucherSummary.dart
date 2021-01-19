import 'dart:convert';
import 'package:apiTesting/loginPage.dart';
import 'package:apiTesting/network/model/dateFormat.dart';
import 'package:apiTesting/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoucherSummary extends StatefulWidget {
  String token;

  DateTime selectedDate;

  DateTime curentDate = DateTime.now();

  VoucherSummary({Key key, @required this.token}) : super(key: key);
  @override
  _VoucherSummaryState createState() => _VoucherSummaryState();
}

class _VoucherSummaryState extends State<VoucherSummary> {
  var api = 'https://goldenfriends.kwintechnologies.com/api/voucher_summary';
  var res, drinks;

  // String date = '2-10-2020';
  String branch_id = '1';

  String auth =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjFmZjVlOTQ4YmNmYzdjNzI2YmQzZGFiNDViMWFiMmMxZjEyYmQxYzQxODNkODFhNWRiZjgyY2RlNmRkYWRlZWFiOWVmM2RiY2I5NWM0NjkiLCJpYXQiOjE2MDI5MTYyODAsIm5iZiI6MTYwMjkxNjI4MCwiZXhwIjoxNjM0NDUyMjgwLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.D1HunKMd__aWXjlmokEMopxxhc0SdWtP-sI8AKXMybdWBNb6e6Zt1zJpafQ4Zrbj4O3n2Pq5LUGW-14qjz7_GQCmTP0TywCl9olTZKphJpvb-zgJZkY-BJ3pwhB1bwhmcaAi34rPYgK-x8XRWTFguvT0r9HjETNvqPLCTXGm7e2QAhhFbpUdpN_-kQWPakyqZsyNTCg83foIHtmeX0wuL82BctLlwxKt-g2dD-hN98MJLEqYa0lFaOOVK3Hp115uMnB16B7UT0UcSYgeWRfPzNHAKovRb-UCtidqs0QxAPvWjTXbiIpMAnIa8pWNza6y32srgluL_wuOKiFUqPh2P2eeNcCkrrDEJQ_bLUGj6rrKCf4XINdgn7U_O1wSqt_uFg-AbK1f04lxk5Hiy1aRZQH0IMM39T0NDAA1PTQHbcYucdk_Iy-aVlQwhtwiybkKV025r0wHYjxOKXIjI0dlOEZLli6Qn52Q7cyQ846VSsahr_xcT1i1t4N90dYuK4jIU-tPlFrGqAy210q3p2h0bFE37f3zJvhOavGoyHdxTyBMczZhBWjyoZDzXmea2pW-VnDbCZFl5nx0alf2laZpO0RFRRHhpwgRZAhqCiwPE3UFQYEX2Sh6ieXCIDopbzv808haeVDG9_SlOG4IN1HmF9gZ9-zGiOEU9d7v2f3Q6mY';

  @override
  void initState() {
    super.initState();
  }

  fetchData() async {
    var message;
    res = await http.post(api, headers: {
      // "Accept": 'application.json',
      'Authorization': "Bearer ${widget.token}"
    }, body: {
      'date': '${widget.selectedDate}',
      'branch_id': branch_id
    });

    if (res == null || widget.selectedDate.compareTo(widget.curentDate) > 0) {
      message = "No data";
      // try {
      //   widget.selectedDate.isAfter(widget.curentDate);
      // } catch (e) {}
    } else {
      drinks = jsonDecode(res.body)['items'];
    }

    print('Response data $drinks');
    print(drinks.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
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
                    height: 50,
                  ),
                  Container(
                    // padding: EdgeInsets.all(8.0),

                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          margin: EdgeInsets.only(left: 20),
                          // color: Colors.white,
                          // padding: EdgeInsets.symmetric(vertical: 5),
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
                              Padding(padding: EdgeInsets.only(left: 16.0)),
                              Text(
                                widget.selectedDate != null
                                    ? appDateForm(widget.selectedDate)
                                    : "select date",
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
                              fetchData();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Name',
                        style: textedit1,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Qty",
                        style: textedit1,
                      ),
                      Text(
                        "Price",
                        style: textedit1,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 200),
              child: res != null
                  ? ListView.builder(
                      itemCount: drinks.length,
                      itemBuilder: (context, index) {
                        var drink = drinks[index];
                        return Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // color: Colors.red,
                              margin: EdgeInsets.only(top: 5),
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 10),
                                    width: 20,
                                    child: Text('${++index}.'),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 3),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "${drink["item_name"]}",
                                      textAlign: TextAlign.start,
                                      // style: textedit,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 10),
                                    width: 20,
                                    child: Text(
                                      "${drink["quantity"]}",
                                      style: textedit,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 55),
                                    width: 40,
                                    child: Text(
                                      "${drink["price"]}",
                                      style: textedit,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )
                  : Text('   '),
            ),
          ],
        ));
  }

  _pickDOB() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    print(pickedDate);
    setState(() {
      widget.selectedDate = pickedDate;
    });
  }
}

const textedit = TextStyle(
  fontSize: 15,
);

const textedit1 = TextStyle(
  fontSize: 17,
  color: Colors.white,
);
