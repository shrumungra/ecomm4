import 'dart:convert';

import 'package:ecomm2/homepage.dart';
import 'package:ecomm2/info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  static SharedPreferences? preff;

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController Email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController remail = TextEditingController();
  TextEditingController rpass = TextEditingController();
  TextEditingController rconpass = TextEditingController();
  data? obj;
  bool islogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status();
  }

  Future<void> status() async {
    login.preff = await SharedPreferences.getInstance();
    setState(() {
      islogin = login.preff!.getBool("loginstatus") ?? false;
    });
    print("=====$islogin");

    if (islogin) {
      Future.delayed(Duration(seconds: 1))
          .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return home();
                },
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Column(children: [
          Expanded(
              flex: 4,
              child: Image(
                  fit: BoxFit.contain,
                  width: width,
                  image: AssetImage("images/hand.png"))),
          Expanded(
              flex: 1,
              child: Text(
                  style: TextStyle(color: Colors.white, fontSize: 35),
                  "Welcome Back!")),
          Expanded(
              flex: 1,
              child: Text(
                  style: TextStyle(color: Colors.white60, fontSize: 20),
                  "Enter your email and password")),
          Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Colors.blueGrey.shade400),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: TabBar(
                        padding: EdgeInsets.all(5),
                        // give the indicator a decoration (color and border radius)
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        labelColor: Theme.of(context).primaryColorLight,
                        unselectedLabelColor:
                            Theme.of(context).primaryColorDark,
                        tabs: [
                          Text("login",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                          Text("signup",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextField(
                                controller: Email,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87,
                                        Icons.person_outline),
                                    labelText: "username",
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    hintText: "Email or Phone number"),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextField(
                                controller: pass,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87,
                                        Icons.lock_outline),
                                    labelText: "password",
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    hintText: "password"),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    Map map = {
                                      "name": Email.text,
                                      "password": pass.text,
                                    };

                                    var url = Uri.parse(
                                        'https://mugra216.000webhostapp.com/register/login.php');
                                    var response =
                                        await http.post(url, body: map);
                                    print(
                                        'Response status: ${response.statusCode}');
                                    print('Response body: ${response.body}');
                                    Map check = jsonDecode(response.body);
                                    print("**********$check");
                                    setState(() {
                                      obj = data.fromJson(check);
                                    });
                                    if (obj!.result == 1) {

                                      String ID=obj!.userdata!.iD.toString();
                                      String NAME=obj!.userdata!.nAME.toString();
                                      String EMAIL=obj!.userdata!.eMAIL.toString();
                                      String NUMBER=obj!.userdata!.nUMBER.toString();
                                      String IMAGE=obj!.userdata!.iMAGE.toString();
                                      login.preff!.setBool('loginstatus', true);
                                      login.preff!.setString("ID", ID);
                                      login.preff!.setString("NAME", NAME);
                                      login.preff!.setString("EMAIL", EMAIL);
                                      login.preff!.setString("NUMBER", NUMBER);
                                      login.preff!.setString("IMAGE", IMAGE);

                                      print("%${obj!.userdata!.nAME}");

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                        builder: (context) {
                                          return home();
                                        },
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("user not found")));
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextField(
                                controller: remail,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87,
                                        Icons.person_outline),
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    hintText: "Email or Phone number"),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextField(
                                controller: rpass,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87,
                                        Icons.lock_outline),
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    hintText: "password"),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: TextField(
                                controller: rconpass,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87,
                                        Icons.lock_outline),
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                    hintText: "confirm password"),
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return info();
                                    },
                                  ));
                                },
                                child: Text(
                                  "Add More Information?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    Map map = {
                                      "email": remail.text,
                                      "password": rpass.text,
                                      "conpass": rconpass.text,
                                    };

                                    var url = Uri.parse(
                                        'https://mugra216.000webhostapp.com/register/register.php');
                                    var response =
                                        await http.post(url, body: map);
                                    print(
                                        'Response status: ${response.statusCode}');
                                    print('Response body: ${response.body}');

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return login();
                                      },
                                    ));
                                  },
                                  child: Text(
                                    "sign up",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
        ]),
      ),
    ));
  }
}

class data {
  int? connection;
  int? result;
  Userdata? userdata;

  data({this.connection, this.result, this.userdata});

  data.fromJson(json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? iD;
  String? nAME;
  String? eMAIL;
  String? nUMBER;
  String? pASSWORD;
  String? cONPASS;
  String? iMAGE;

  Userdata(
      {this.iD,
      this.nAME,
      this.eMAIL,
      this.nUMBER,
      this.pASSWORD,
      this.cONPASS,
      this.iMAGE});

  Userdata.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    eMAIL = json['EMAIL'];
    nUMBER = json['NUMBER'];
    pASSWORD = json['PASSWORD'];
    cONPASS = json['CONPASS'];
    iMAGE = json['IMAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['EMAIL'] = this.eMAIL;
    data['NUMBER'] = this.nUMBER;
    data['PASSWORD'] = this.pASSWORD;
    data['CONPASS'] = this.cONPASS;
    data['IMAGE'] = this.iMAGE;
    return data;
  }
}
