import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/mains_screen.dart';
import 'package:order_management/order/product_detail.dart';

class MainRetailerPage extends StatefulWidget {
  final area;
  const MainRetailerPage({super.key, required this.area});

  @override
  State<MainRetailerPage> createState() => _MainRetailerPageState();
}

class _MainRetailerPageState extends State<MainRetailerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Retailers App",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MainScreen()),
                            (route) => false)
                      });
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          backgroundColor: Colors.purple,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("products").snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var snap = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Product Name:" + snap['productname']),
                            Text("Product Pcs:" + snap['pcs']),
                          ],
                        ),
                        trailing: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ProductDetail(
                                            area: widget.area,
                                            uuid: snap['uuid'],
                                            rate: snap['rate'],
                                            dimension: snap['dimensions'],
                                            pcs: snap['pcs'],
                                            productname: snap['productname'],
                                          )));
                            },
                            child: Text("View")),
                      ),
                    );
                  });
            }));
  }
}