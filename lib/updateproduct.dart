import 'dart:convert';
import 'dart:io';
import 'package:ecomm2/Viewproduct.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class update extends StatefulWidget {
  Productdata? productdata;


  update(this.productdata);

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {

  TextEditingController npname = TextEditingController();
  TextEditingController nprice = TextEditingController();
  TextEditingController ndes = TextEditingController();
  TextEditingController ndis = TextEditingController();
  final ImagePicker npicker = ImagePicker();
  XFile? image;
  String nimagepath = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("===========${widget.productdata!.tHAMBNAIL}");
    print("===========${widget.productdata!.lOGINID}");

    npname.text=widget.productdata!.tITLE!;
    nprice.text=widget.productdata!.pRICE!;
    ndes.text=widget.productdata!.dESCRIPTION!;
    ndis.text=widget.productdata!.dISCOUNT!;
    nimagepath=widget.productdata!.tHAMBNAIL!;

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () async {
                          image = await npicker.pickImage(source: ImageSource.gallery);
                        },
                        child: Card(
                          elevation: 20,
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:NetworkImage("https://mugra216.000webhostapp.com/register/${nimagepath}"))),
                          ),
                        )),
                    InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 20,
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Icon(Icons.add_circle_outline),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(50)),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 25,
                      child: TextField(
                        controller: npname,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // errorText: validate1 ? error : null,
                            prefixIcon: Icon(color: Colors.black87, Icons.add),
                            labelStyle: TextStyle(color: Colors.black87),
                            hintText: "product name"),
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 25,
                      child: TextField(
                        controller: nprice,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // errorText: validate1 ? error : null,
                            prefixIcon: Icon(color: Colors.black87, Icons.add),
                            labelStyle: TextStyle(color: Colors.black87),
                            hintText: "price"),
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 25,
                      child: TextField(
                        controller: ndis,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // errorText: validate1 ? error : null,
                            prefixIcon: Icon(color: Colors.black87, Icons.add),
                            labelStyle: TextStyle(color: Colors.black87),
                            hintText: "discount"),
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 25,
                      child: TextField(
                        controller: ndes,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // errorText: validate1 ? error : null,
                            prefixIcon: Icon(color: Colors.black87, Icons.add),
                            labelStyle: TextStyle(color: Colors.black87),
                            hintText: "description"),
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                    )
                  ])),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {

                List<int> imgbyte = File(image!.path).readAsBytesSync();
                String imagedata = base64Encode(imgbyte);
                print("======nimgencodedata$imagedata");

              },
              child: Icon(Icons.add)),
        ),
      ),
    );
  }
}
