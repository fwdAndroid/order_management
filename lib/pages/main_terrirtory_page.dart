import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/mains_screen.dart';
import 'package:order_management/order/territory_manager_order_page.dart';
import 'package:order_management/tabs/territory_orders_tab.dart';

class MainTerritoryPage extends StatefulWidget {
  const MainTerritoryPage({super.key});

  @override
  State<MainTerritoryPage> createState() => _MainTerritoryPageState();
}

class _MainTerritoryPageState extends State<MainTerritoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => TerritoryOrderTab()));
                },
                child: Text(
                  "History",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (builder) => MainScreen()));
                  });
                },
                child: Text(
                  "LogOut",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
          title: Text("Territory Manager Page"),
          backgroundColor: Colors.purple,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("teritory")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              var ds = snapshot.data;

              if (!snapshot.hasData) {
                Center(
                  child: Text("No Product Listed"),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 300,
                      width: 300,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                "Territory Profile Info:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Territory Manager Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text("Name:" + ds['name']),
                            Divider(),
                            Text(
                              "Territory Manager Email:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(ds['email']),
                            Divider(),
                            Text(
                              "Territory Manager Area:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(ds['area']),
                            Divider(),
                            Text(
                              "Territory Manager Password:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(ds['password']),
                            // trailing: TextButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (builder) => ProductDetail(
                            //                     area: widget.area,
                            //                     name: widget.name,
                            //                     uuid: snap['uuid'],
                            //                     rate: snap['rate'],
                            //                     dimension: snap['dimensions'],
                            //                     pcs: snap['pcs'],
                            //                     productname: snap['productname'],
                            //                   )));
                            //     },
                            //     child: Text("View")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(ds['email']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => TerritoryManagerOrderPage(
                                    area: ds['area'],
                                    email: ds['email'],
                                    name: ds['name'],
                                  )));
                    },
                    child: Text("View Orders"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        fixedSize: Size(200, 50),
                        shape: StadiumBorder()),
                  )
                ],
              );
            }));
    ;
  }
}
