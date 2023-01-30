import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:order_management/pages/main_distributor_page.dart';
import 'package:order_management/pages/main_sales_page.dart';
import 'package:order_management/widgets/utils.dart';

class SalesOfficerReview extends StatefulWidget {
  final productName;
  final DistributorName;
  final uuid;
  final SalesOfficerArea;
  final SalesOfficerName;

  const SalesOfficerReview(
      {super.key,
      required this.SalesOfficerName,
      required this.uuid,
      required this.SalesOfficerArea,
      required this.DistributorName,
      required this.productName});

  @override
  State<SalesOfficerReview> createState() => _SalesOfficerReviewState();
}

class _SalesOfficerReviewState extends State<SalesOfficerReview> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _pcController = TextEditingController();
    print(widget.SalesOfficerName);
    print(widget.DistributorName);
    print(widget.uuid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Sales Officer Review Page"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("teritory")
              .where("area", isEqualTo: widget.SalesOfficerArea)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            print(snapshot);

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> snap =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Territory Manager Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            snap['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Territory Manager Email",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            snap['email'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Divider(),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Territory Manager Area",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 2),
                          child: Text(
                            snap['area'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Divider(),
                      Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: Text(
                            "Rewrite Number of PCS You want",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17),
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 4),
                        child: TextFormField(
                          controller: _pcController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Update Your Pieces",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection("orders")
                                .doc(widget.uuid)
                                .update({
                              "PCS": _pcController.text,
                              "Territory Manager Name": snap['name'],
                              "Territory Area": snap['area'],
                              "salesUid": FirebaseAuth.instance.currentUser!.uid
                            });
                            Customdialog().showInSnackBar("Update", context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => MainSalesPage()));
                          },
                          child: Text('Proceed'),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 50),
                              backgroundColor: Colors.purple,
                              shape: StadiumBorder()),
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}
