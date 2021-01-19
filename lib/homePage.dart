import 'package:apiTesting/loginPage.dart';
import 'package:apiTesting/network/screeens/VoucherAll.dart';
import 'package:apiTesting/network/screeens/VoucherPAndL.dart';
import 'package:apiTesting/network/screeens/voucherSummary.dart';
import 'package:apiTesting/textStyle.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({Key key, @required this.token}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Golden Friends"),
      ),
      body: Center(
          child: Stack(
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
                  height: 90,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Card(
                // color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                // margin: EdgeInsets.only(top: 200),
                margin: EdgeInsets.only(top: 140, left: 40, right: 40),

                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoucherPAndL(
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 120,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Image(
                                image:
                                    AssetImage('assets/images/voucher.jpg'))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Golden Friends",
                              style: textEditStyle,
                            ),
                            Text(
                              "Profit and Loss",
                              style: textEditiStyle1,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.only(top: 30, left: 40, right: 40),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoucherAll(
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 120,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Image(
                                image:
                                    AssetImage('assets/images/voucher.jpg'))),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Golden Friends",
                              style: textEditStyle,
                            ),
                            Text(
                              "Voucher History",
                              style: textEditiStyle1,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.only(top: 30, left: 40, right: 40),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoucherSummary(
                          token: widget.token,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 120,
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Image(
                            image: AssetImage('assets/images/voucher.jpg'),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Golden Friends",
                              style: textEditStyle,
                            ),
                            Text(
                              "Voucher Summary",
                              style: textEditiStyle1,
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
