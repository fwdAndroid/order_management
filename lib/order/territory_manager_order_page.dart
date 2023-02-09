import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_management/order/distributor_order_detail_page.dart';
import 'package:order_management/order/sales_officer_order_detail_page.dart';
import 'package:order_management/order/territroy_manager_order_detail.dart';

class TerritoryManagerOrderPage extends StatefulWidget {
  final email, name, area;
  const TerritoryManagerOrderPage(
      {super.key, required this.area, required this.name, required this.email});

  @override
  State<TerritoryManagerOrderPage> createState() =>
      _TerritoryManagerOrderPageState();
}

class _TerritoryManagerOrderPageState extends State<TerritoryManagerOrderPage> {
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
              .where("Status", isEqualTo: "Active")
              .where("Territory Manager Name", isEqualTo: widget.name)
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
                          "Sales Officer Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Sales Officer Name'])),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Sales Officer Area:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Sales Officer Area'])),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    TerritoryManagerDetailPage(
                                      uuid: snap['uuid'],
                                      territoryname: widget.name,
                                      territroyarea: widget.area,
                                      territoryemail: widget.email,
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
