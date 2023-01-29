import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_management/order/distributor_order_detail_page.dart';

class DistributorOrderPage extends StatefulWidget {
  final email, name, area;
  const DistributorOrderPage(
      {super.key, required this.area, required this.name, required this.email});

  @override
  State<DistributorOrderPage> createState() => _DistributorOrderPageState();
}

class _DistributorOrderPageState extends State<DistributorOrderPage> {
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
              .where("Distributor Manager Name", isEqualTo: widget.name)
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
                          "Retailer Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['RetailerName'])),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Retailer Area:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(snap['Retailer Area'])),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    DistributorOrderDetailPage(
                                      distributorname: widget.name,
                                      distributorarea: widget.area,
                                      distributoremail: widget.email,
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
