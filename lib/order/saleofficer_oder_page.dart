import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_management/order/distributor_order_detail_page.dart';
import 'package:order_management/order/sales_officer_order_detail_page.dart';

class SalesOfficerOrderPage extends StatefulWidget {
  final email, name, area;
  const SalesOfficerOrderPage(
      {super.key, required this.area, required this.name, required this.email});

  @override
  State<SalesOfficerOrderPage> createState() => _SalesOfficerOrderPageState();
}

class _SalesOfficerOrderPageState extends State<SalesOfficerOrderPage> {
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
              .where("Sales Officer Name", isEqualTo: widget.name)
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
                          "Distributor Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Distributor Manager Name'])),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Distributor Area:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Distributor Area'])),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    SalesOfficerOrderDetailPage(
                                      uuid: snap['uuid'],
                                      saleofficername: widget.name,
                                      salesofficerarea: widget.area,
                                      salesofficeremail: widget.email,
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
