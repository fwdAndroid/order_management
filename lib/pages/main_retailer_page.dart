import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/mains_screen.dart';
import 'package:order_management/order/product_detail.dart';
import 'package:order_management/tabs/retailier_orders_tabs.dart';

class MainRetailerPage extends StatefulWidget {
  final area;
  final name;
  const MainRetailerPage({super.key, this.area, this.name});

  @override
  State<MainRetailerPage> createState() => _MainRetailerPageState();
}

class _MainRetailerPageState extends State<MainRetailerPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Retailers App",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => RetailerOrdersTabs()));
                    },
                    child: Text(
                      "History",
                      style: TextStyle(color: Colors.white),
                    )),
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
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    Center(
                      child: Text("No Product Listed"),
                    );
                  }
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
                                                name: widget.name,
                                                uuid: snap['uuid'],
                                                rate: snap['rate'],
                                                dimension: snap['dimensions'],
                                                pcs: snap['pcs'],
                                                productname:
                                                    snap['productname'],
                                              )));
                                },
                                child: Text("View")),
                          ),
                        );
                      });
                }));
  }
}
