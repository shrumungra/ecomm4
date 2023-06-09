import 'dart:convert';
import 'dart:io';

import 'package:ecomm2/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  TextEditingController pname = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController dis = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imagepath = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          InkWell(
              onTap: () async {
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  imagepath = image!.path;
                });
              },
              child: imagepath == ""
                  ? Card(
                      elevation: 20,
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        child: Icon(Icons.add_circle_outline),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(60),
                          ),
                        ),
                      ),
                    )
                  : Card(
                      elevation: 20,
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(imagepath)))),
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
              controller: pname,
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
              controller: price,
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
              controller: dis,
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
              controller: des,
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
              List<int> imgbyte = File(imagepath).readAsBytesSync();
              String imagedata = base64Encode(imgbyte);
              print("======imagestring$imagedata");

              Map map = {
                "loginid": home.id,
                "title": pname.text,
                "des": des.text,
                "price": price.text,
                "dis": dis.text,
                "thumbnail": imagedata,
                "images": "",
              };

              var url = Uri.parse(
                  'https://mugra216.000webhostapp.com/register/product.php');
              var response = await http.post(url, body: map);
              print('Response status: ${response.statusCode}');
              print('Response body: ${response.body}');
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}
