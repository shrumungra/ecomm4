import 'dart:convert';

import 'package:ecomm2/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  Cartproduct? cart;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view();
  }

  Future<void> view() async {
    Map map = {
      "loginid": home.id.toString(),
    };

    var url = Uri.parse(
        'https://mugra216.000webhostapp.com/register/viewcart.php');
    var response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map map1 = jsonDecode(response.body);
    setState(() {
      cart = Cartproduct.fromJson(map1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Cart"),
          actions: <Widget>[
            ElevatedButton(
                child: Text(
                  "Clear",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {})
          ],
        ),
        body:cart!.cartdata!.length==0
            ? Center(
          child: Text("No items in Cart"),
        )
            : Container(
            padding: EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: cart!.cartdata!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                          title: Text("${cart!.cartdata![index].tITLE}"),
                          subtitle: Text("${cart!.cartdata![index].pRICE}"),
                        );
                      },
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Total: \$ " + ""+
                        "",
                    style: TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("BUY NOW"),
                    onPressed: () {},
                  ))
            ])));

  }
}
class Cartproduct {
  int? connection;
  int? result;
  List<Cartdata>? cartdata;

  Cartproduct({this.connection, this.result, this.cartdata});

  Cartproduct.fromJson( json) {
    connection = json['connection'];
    result = json['result'];
    if (json['cartdata'] != null) {
      cartdata = <Cartdata>[];
      json['cartdata'].forEach((v) {
        cartdata!.add(new Cartdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.cartdata != null) {
      data['cartdata'] = this.cartdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cartdata {
  String? cID;
  String? tITLE;
  String? dESCRIPTION;
  String? pRICE;
  String? dISCOUNT;
  String? tHAMBNAIL;
  String? iMAGES;
  String? lOGINID;

  Cartdata(
      {this.cID,
        this.tITLE,
        this.dESCRIPTION,
        this.pRICE,
        this.dISCOUNT,
        this.tHAMBNAIL,
        this.iMAGES,
        this.lOGINID});

  Cartdata.fromJson(Map<String, dynamic> json) {
    cID = json['CID'];
    tITLE = json['TITLE'];
    dESCRIPTION = json['DESCRIPTION'];
    pRICE = json['PRICE'];
    dISCOUNT = json['DISCOUNT'];
    tHAMBNAIL = json['THAMBNAIL'];
    iMAGES = json['IMAGES'];
    lOGINID = json['LOGINID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CID'] = this.cID;
    data['TITLE'] = this.tITLE;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['PRICE'] = this.pRICE;
    data['DISCOUNT'] = this.dISCOUNT;
    data['THAMBNAIL'] = this.tHAMBNAIL;
    data['IMAGES'] = this.iMAGES;
    data['LOGINID'] = this.lOGINID;
    return data;
  }
}
