import 'dart:convert';
import 'package:apiTesting/network/screeens/voucherSummary.dart';
import 'package:apiTesting/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VoucherDetail extends StatefulWidget {
  var data;
  String token;

  VoucherDetail({Key key, @required this.data, @required this.token})
      : super(key: key);

  @override
  _VoucherDetailState createState() => _VoucherDetailState();
}

class _VoucherDetailState extends State<VoucherDetail> {
  var api = 'https://goldenfriends.kwintechnologies.com/api/voucher_selected';

  var res, drinks;

  String auth =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZmMzN2Y2NDE5Mjc3YmYxMmQ1MDdjODIxYTY2ZjdlNmZjN2E5MjBhNTA5OTQwZDJlMmY5Y2Q1Mjc2NWNkNmU3N2FmMTk1YTE5YThkM2Y3NjAiLCJpYXQiOjE2MDA0Mzg5NDQsIm5iZiI6MTYwMDQzODk0NCwiZXhwIjoxNjMxOTc0OTQ0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.uKX6LayJLRVg_KTIdGo5522h-xKWjaPG2-24hE-bHHrmgRseSwlZOL_6Z_EMaXjBJP7f8r1uCgmPOi6GwR2AMXW2e8hWRRsjFeh681-ACrOIfGmkYIPFrsPOiJy6-Qmqt3fGslGL2FdgWeKUPlBNucXC8JIhXeoQc4IbHCkkgZIbcyYJsJgg6Mk_GObHJ3qvBPBbjcOCYWdPZ1voi75IwuiFLJBgUDCG4eym_8vkpW9ib1X4a3VOMs5RbsIHebXvdxHqbyObopw3Ye82LqLIs0Y1V7bIzJMfz4tXNCtSt6rRV5t7tAqiUNlotujJp9zqRI8POjK6Bt13mX-0-w802KXyg78X65OhVTNX4UROPNx42is5XYzOklaTozGnj0X6cr8_lFYBTkSf-Rrib08kLbUn8DKIhaEgE0ASXC6Kd8zTLFvClpwklF6dQ-pMPmYxYQJrMb6GCy1jYJKTkER-GS-652lgKDp9sd5kXDyXwxL-CSEXtnmne3_lz0eUKKFsoTwuJaDf8dhL_2wUcXHX8-38CFrSkOOYgibxoYEuWabmXM-h0lmrWMnT7KOkL1YNyKrjNLnJu3fxLcgq7Gms50Exd2ZvANgFNR6Pt3Hb9FTx9k_Gf29CO0yl5CanrEgBUryEglOwGoKGANlvR6stGlWNQOBG8XAdsxZETkno9I8';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    res = await http.post(api, headers: {
      "Accept": 'application/json',
      'Authorization': "Bearer ${widget.token}"
    }, body: {
      'id': '${widget.data['id']}'
    });

    drinks = jsonDecode(res.body)['item_lists'];
    print('Response data $drinks');
    print(drinks.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Golden Friends"),
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 210,
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No : ${widget.data['voucher_code']}',
                            style: textedit1,
                          ),
                          Text(
                            'Sale By : ${widget.data['sale_by']}',
                            style: textedit1,
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      Text(
                        "Yangon Than Street",
                        style: textedit1,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
            Center(
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 2,
                      // color: Colors.red,
                      margin: EdgeInsets.only(top: 220),
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
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      // color: Colors.red,
                                      margin: EdgeInsets.only(top: 5),
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              "${drink["item_name"]}",
                                              style: textedit,
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
                                            width: 50,
                                            child: Text(
                                              "${drink["selling_price"]}",
                                              style: textedit,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : Text(" ")),
                  Container(
                    // margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Total Qty : ${widget.data['total_quantity']}",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.green,
                        ),
                        Text(
                          "Grand Total : ${widget.data['total_price']}",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
