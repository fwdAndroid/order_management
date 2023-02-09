import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_management/order/area_manager_detail_page.dart';
import 'package:order_management/order/distributor_order_detail_page.dart';
import 'package:order_management/order/sales_officer_order_detail_page.dart';
import 'package:order_management/order/territroy_manager_order_detail.dart';
import 'package:order_management/order/zonal_order_detail_page.dart';

class ZonalOrderPage extends StatefulWidget {
  final email, name, area;
  const ZonalOrderPage(
      {super.key, required this.area, required this.name, required this.email});

  @override
  State<ZonalOrderPage> createState() => _ZonalOrderPageState();
}

class _ZonalOrderPageState extends State<ZonalOrderPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.area);
    print(widget.name);
    print(widget.email);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Order Detail"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("orders")
              .where("Zonal Manager Name", isEqualTo: widget.name)
              .where("Status", isEqualTo: "Active")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              Center(child: Text("No Thing Found"));
            } else if (!snapshot.hasData) {
              Center(child: Text("No Thing Found Data"));
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var snap = snapshot.data!.docs[index];

                  return Card(
                      child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          "Area Manager Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Area Manager Name'])),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Area Manager Area:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Area Area'])),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ZonalOrderDetailPage(
                                      uuid: snap['uuid'],
                                      areaname: widget.name,
                                      areaarea: widget.area,
                                      areaemail: widget.email,
                                    )));
                      },
                      child: Text("View"),
                    ),
                  ));
                });
          }),
    );
  }
}
