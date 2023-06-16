import 'package:ecomm2/Cart.dart';
import 'package:ecomm2/Viewproduct.dart';
import 'package:ecomm2/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class sp extends StatefulWidget {
  Productdata productdata;

  sp(this.productdata);

  @override
  State<sp> createState() => _spState();
}

class _spState extends State<sp> {
  double? price;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var rupees = int.parse(widget.productdata.pRICE.toString());
    var discount = int.parse(widget.productdata.dISCOUNT.toString());
    price = (rupees / (1 - discount / 100));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorLight,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 10),
                Container(
                    height: 380,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://mugra216.000webhostapp.com/register/${widget.productdata!.tHAMBNAIL}")))),
                Column(
                  children: [
                    ListTile(
                      title: Text("view more from ${widget.productdata.tITLE}",
                          style: TextStyle(fontSize: 50)),
                      subtitle: Text("${widget.productdata.dESCRIPTION}"),
                    ),
                    ListTile(
                        title: Text(
                            style: TextStyle(fontSize: 45),
                            "${widget.productdata.dISCOUNT}% off")),
                    ListTile(
                      subtitle: Text("$price"),
                      title: Text(
                          style: TextStyle(fontSize: 45),
                          "${widget.productdata.pRICE}/- "),
                    )
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(color: Theme.of(context).primaryColorLight,
            child: Row(children: [
              Expanded(
                child: ElevatedButton(style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () async {
                    Map map = {
                      "loginid": home.id,
                      "title": widget.productdata.tITLE.toString(),
                      "des": widget.productdata.dESCRIPTION.toString(),
                      "price": widget.productdata.pRICE.toString(),
                      "dis": widget.productdata.dISCOUNT.toString(),
                      "thumbnail": widget.productdata.tHAMBNAIL.toString(),
                      "images": widget.productdata.iMAGES.toString(),
                    };
                    print('Response body:');

                    var url = Uri.parse(
                        'https://mugra216.000webhostapp.com/register/cartproduct.php');
                    var response = await http.post(url, body: map);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Cart();
                    },));
                  },
                  child: Text("Add to cart",style: TextStyle(color: Colors.white),),
                ),
              ),
              Expanded(
                child: MaterialButton(color: Theme.of(context).primaryColor,
                  onPressed: () {  },
                  child: Text("Buy now",style: TextStyle(color: Colors.white),),
                ),
              )
            ]),
          )),
    );
  }
}
