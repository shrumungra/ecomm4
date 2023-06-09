import 'dart:convert';
import 'dart:io';
import 'package:ecomm2/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class info extends StatefulWidget {
  const info({Key? key}) : super(key: key);

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  TextEditingController name= TextEditingController();
  TextEditingController Email= TextEditingController();
  TextEditingController Phone= TextEditingController();
  TextEditingController Password= TextEditingController();
  TextEditingController Conpass= TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imagepath = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: SingleChildScrollView(
            child: Column(children: [
              Text(
                  style: TextStyle(color: Colors.white, fontSize: 25),
                  "let's Get you started"),
              Text(style: TextStyle(color: Colors.white, fontSize: 35), "Sign Up"),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * .5,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              child: TextField(controller: name,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87, Icons.lock_outline),
                                    labelStyle: TextStyle(color: Colors.black87),
                                    hintText: "Name"),
                                style:
                                TextStyle(color: Colors.black87, fontSize: 20),
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
                              child: TextField(controller: Email,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87, Icons.lock_outline),
                                    labelStyle: TextStyle(color: Colors.black87),
                                    hintText: "Email "),
                                style:
                                TextStyle(color: Colors.black87, fontSize: 20),
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
                              child: TextField(controller: Phone,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    // errorText: validate1 ? error : null,
                                    prefixIcon: Icon(
                                        color: Colors.black87, Icons.lock_outline),
                                    labelStyle: TextStyle(color: Colors.black87),
                                    hintText: "Phone"),
                                style:
                                TextStyle(color: Colors.black87, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                          setState(() {
                            imagepath = image!.path;
                          });
                        },
                        child: imagepath != ""
                            ? CircleAvatar(
                          maxRadius: 80,
                          backgroundImage: FileImage(File(imagepath)),
                        )
                            : CircleAvatar(
                          maxRadius: 80,
                          backgroundColor: Colors.white24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: TextField(controller: Password,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // errorText: validate1 ? error : null,
                              prefixIcon:
                              Icon(color: Colors.black87, Icons.lock_outline),
                              labelStyle: TextStyle(color: Colors.black87),
                              hintText: "password"),
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: TextField(controller: Conpass,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // errorText: validate1 ? error : null,
                              prefixIcon:
                              Icon(color: Colors.black87, Icons.lock_outline),
                              labelStyle: TextStyle(color: Colors.black87),
                              hintText: "Confirm password"),
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(onPressed: () async {

                List<int> imgbyte=File(imagepath).readAsBytesSync();
                String imagedata =  base64Encode(imgbyte);
                print("======imagestring$imagedata");


                Map map = {
                  "name": name.text,
                  "email": Email.text,
                  "number": Phone.text,
                  "password": Password.text,
                  "conpass": Conpass.text,
                  "imagedata": imagedata
                };

                var url = Uri.parse('https://mugra216.000webhostapp.com/register/data.php');
                var response = await http.post(url, body:map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return login();
                },));
              }, child: Text("sign up"))
            ]),
          ),
        ));
  }
}
