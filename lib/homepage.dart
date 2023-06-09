import 'package:ecomm2/Addproduct.dart';
import 'package:ecomm2/Cart.dart';
import 'package:ecomm2/Viewproduct.dart';
import 'package:ecomm2/login.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);
  static String? id;
  static String? name;
  static String? email;
  static String? number;
  static String? userdp;

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  List<Widget> Class=[Viewproduct(),Addproduct(),Cart()];
  int cnt=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();

  }

  void getdata() {

    setState(() {
      home.id=login.preff!.getString("ID")??"";
      home.name=login.preff!.getString("NAME")??"";
      home.email=login.preff!.getString("EMAIL")??"";
      home.number=login.preff!.getString("NUMBER")??"";
      home.userdp=login.preff!.getString("IMAGE")??"";
    });


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero,
              children: [
                DrawerHeader(decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
                    child: Column(
                      children: [
                        CircleAvatar(maxRadius: 40,
                          backgroundImage: NetworkImage("https://mugra216.000webhostapp.com/register/${home.userdp}"),
                        ),
                        Text(
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 30),
                            "${home.name}"),
                        Text(
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                            "${home.email}"),
                      ],
                    )),
                ListTile(
                  onTap: () {
                    setState(() {
                      cnt=1;
                    });
                    Navigator.pop(context);
                  },
                  leading: Icon(Icons.logout_outlined),
                  title: Text(style: TextStyle(fontSize: 17), "Add product"),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      cnt=0;
                    });
                    Navigator.pop(context);

                  },
                  leading: Icon(Icons.logout_outlined),
                  title: Text(style: TextStyle(fontSize: 17), "View product"),
                ),
                ListTile(
                  onTap: () {
                    setState(() {
                      cnt=2;
                    });
                    Navigator.pop(context);

                  },
                  leading: Icon(Icons.logout_outlined),
                  title: Text(style: TextStyle(fontSize: 17), "Cart"),
                ),
                ListTile(
                  onTap: () {

                    login.preff!.setBool("loginstatus", false);

                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return login();
                      },
                    ));
                  },
                  leading: Icon(Icons.logout_outlined),
                  title: Text(style: TextStyle(fontSize: 17), "Log out"),
                ),
              ],
            ),
          ),
        body: Class[cnt],),
    );
  }

}
