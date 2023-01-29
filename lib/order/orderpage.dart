import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class OrderPage extends StatefulWidget {
  final String rate, dimension, pcs, productname, uuid;
  final area;
  const OrderPage(
      {super.key,
      required this.dimension,
      required this.area,
      required this.uuid,
      required this.pcs,
      required this.productname,
      required this.rate});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String values = "Distributor Name";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text("Order Page"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              "assets/splash.png",
              height: 250,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("distrubutor")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  const Text("Loading.....");
                else {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: DropdownSearch<String>(
                            selectedItem: values,
                            items: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return data["name"];
                                })
                                .toList()
                                .cast<String>(),
                            onChanged: (String? select) {
                              select = values;
                            }),
                      ),
                    ],
                  );
                }

                return Text("Data");
              }),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 4),
              child: Text(
                "Product Name",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 2),
              child: Text(
                widget.productname,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 14),
              child: Text(
                "Dimensions",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 2),
              child: Text(
                widget.dimension,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 20),
              child: Text(
                "Number of Pcs",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
            margin: EdgeInsets.only(left: 10, right: 15, top: 4),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: widget.pcs,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 4),
              child: Text(
                "Rate",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 2),
              child: Text(
                widget.rate,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              )),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                print(widget.area);
                print(widget.uuid);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => OrderPage(
                              area: widget.area,
                              uuid: widget.uuid,
                              dimension: widget.dimension,
                              pcs: widget.pcs,
                              productname: widget.productname,
                              rate: widget.rate,
                            )));
              },
              child: Text("Order"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  fixedSize: Size(250, 50),
                  shape: StadiumBorder()),
            ),
          )
        ],
      ),
    );
  }
}
