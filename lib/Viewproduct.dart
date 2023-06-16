import 'dart:convert';

import 'package:ecomm2/Addproduct.dart';
import 'package:ecomm2/Cart.dart';
import 'package:ecomm2/homepage.dart';
import 'package:ecomm2/product.dart';
import 'package:ecomm2/updateproduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Viewproduct extends StatefulWidget {
  const Viewproduct({Key? key}) : super(key: key);

  @override
  State<Viewproduct> createState() => _ViewproductState();
}

class _ViewproductState extends State<Viewproduct> {
  Product? product;

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
        'https://mugra216.000webhostapp.com/register/viewproduct.php');
    var response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map map1 = jsonDecode(response.body);
    setState(() {
      product = Product.fromJson(map1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: product != null
          ? GridView.builder(
              itemCount: product!.productdata!.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: .7,crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return sp(product!.productdata![index]);
                  },));
                },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(flex: 1,
                                child: Row( mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: Text("${product!.productdata![index].pRICE}/-")),
                                PopupMenuButton<int>(
                                  offset: Offset(30,0),
                                  padding: EdgeInsets.only(left: 80),
                                  color: Colors.black54,
                                  elevation: 20,
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text("update",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        value:1,
                                      ),
                                      PopupMenuItem(
                                        child: Text("delete",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        value: 2,
                                      )
                                    ];
                                  },onSelected: (value) {
                                    if(value==1){
                                      print("object");
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return update(product!.productdata![index]);
                                      },));
                                    }
                                  },
                                )
                              ],
                            )),
                            SizedBox(
                              height: 3,
                            ),
                            Flexible(flex: 3,
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                child: Image(fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://mugra216.000webhostapp.com/register/${product!.productdata![index].tHAMBNAIL}")),
                              ),
                            ),
                            Flexible(flex: 2,
                              child: ListTile(
                                selectedTileColor: Colors.pink,
                                title:
                                    Text("${product!.productdata![index].tITLE}"),
                                subtitle: Text(
                                    "${product!.productdata![index].dESCRIPTION}"),
                              ),
                            )
                          ]),
                    ),
                  ),
                );
              },
            )
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 20,
                  child: Column(children: [
                    Text(""),
                    ListTile(
                      title: Text(""),
                      subtitle: Text(""),
                    )
                  ]),
                );
              },
            ),
    );
  }
}

class Product {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  Product({this.connection, this.result, this.productdata});

  Product.fromJson(json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? pID;
  String? tITLE;
  String? dESCRIPTION;
  String? pRICE;
  String? dISCOUNT;
  String? tHAMBNAIL;
  String? iMAGES;
  String? lOGINID;

  Productdata(
      {this.pID,
      this.tITLE,
      this.dESCRIPTION,
      this.pRICE,
      this.dISCOUNT,
      this.tHAMBNAIL,
      this.iMAGES,
      this.lOGINID});

  Productdata.fromJson(Map<String, dynamic> json) {
    pID = json['PID'];
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
    data['PID'] = this.pID;
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
