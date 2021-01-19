import 'dart:convert';
import 'package:apiTesting/homePage.dart';
import 'package:apiTesting/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCodeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var api = 'https://goldenfriends.kwintechnologies.com/api/authenticate';
  var res, drinks;

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  fetchData(String userCodeController, String emailController,
      String passwordController) async {
    res = await http.post(api, body: {
      'user_code': userCodeController,
      'email': emailController,
      'password': passwordController
    });

    drinks = jsonDecode(res.body);
    print('Response data : $drinks');
    print('String Response  ${drinks.toString()}');
    print("Access Token   :" + drinks['access_token']);
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) => HomePage(
                token: drinks['access_token'],
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<AuthModel> futureAuthModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Golden Friends"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150, left: 20, right: 20),
              height: 450,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.green,
                  width: 0.0,
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Text(
                  //   "Login",
                  //   style: TextStyle(fontSize: 23, color: Colors.green),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 80,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/voucher.jpg'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: userCodeController,
                      cursorColor: Theme.of(context).cursorColor,
                      maxLength: 20,
                      initialValue: null,
                      decoration: InputDecoration(
                        labelText: 'User Code',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: Theme.of(context).cursorColor,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: passwordController,
                      cursorColor: Theme.of(context).cursorColor,
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6200EE)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green)),
                    color: Colors.white,
                    onPressed: () {
                      fetchData(userCodeController.text, emailController.text,
                          passwordController.text);
                      // saveTokenPreference();
                      // print('Display Token ${drinks['access_token']}');

                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (c) => HomePage()));
                      // setState(() {
                      //   futureAuthModel = fetchAlbum(userCodeController.text,
                      //       mailController.text, passwordController.text);
                      // });
                    },
                    child: Text(
                      "Login",
                      style: texteditLogin1,
                    ),
                  ),
                  // Text(drinks['access_token']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void saveToken() {
  //   String token = drinks['access_token'];
  //   print("Token + $token");
  //   saveTokenPreference(token).then((bool commited) {
  //     Navigator.of(context).push(MaterialPageRoute(builder: (c) => HomePage()));
  //   });
  // }

  // void saveTokenPreference() async {
  //   String token = drinks['access_token'];
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var accessToken = prefs.setString('access_token', token);
  // }

  // void saveToken1() {
  //   String tok = drinks['access_token'];
  //   var token = Provider.of<FutureObject>(context, listen: true);
  //   var to = token.setStringToSF(tok);
  //   print("Token : $to");
  //   Navigator.of(context).push(MaterialPageRoute(builder: (c) => HomePage()));
  // }

  // Future<bool> saveTokenPreference(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var preString = prefs.setString('token', token);
  //   return preString;
  // }

  // Future<String> getTokenPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token');
  //   return token;
  // }
}
