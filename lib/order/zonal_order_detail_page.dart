import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:order_management/database/db.dart';
import 'package:order_management/review/area_order_review.dart';
import 'package:order_management/review/distributor_order_review.dart';
import 'package:order_management/review/sales_officer_order_review.dart';
import 'package:order_management/review/territory_order_review.dart';
import 'package:order_management/review/zonal_order_review.dart';
import 'package:order_management/widgets/utils.dart';

class ZonalOrderDetailPage extends StatefulWidget {
  final String areaarea, areaemail, areaname;
  const ZonalOrderDetailPage({
    super.key,
    required this.areaarea,
    required this.areaname,
    required this.areaemail,
  });

  @override
  State<ZonalOrderDetailPage> createState() => _ZonalOrderDetailPageState();
}

class _ZonalOrderDetailPageState extends State<ZonalOrderDetailPage> {
  TextEditingController _pcsControleler = TextEditingController();
  var values;

  @override
  Widget build(BuildContext context) {
    TextEditingController _pcsControleler = TextEditingController();
    print(widget.areaarea);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text("Zonal Manager Order Page"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              "assets/splash.png",
              height: 200,
            ),
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("orders")
                .where("Zonal Manager Name", isEqualTo: widget.areaname)
                .get(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              print(widget.areaname);

              print(widget.areaarea);
              if (!snapshot.hasData)
                const Text("Loading.....");
              else {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext ctx, index) {
                        Map<String, dynamic> snap = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "Product Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 2),
                                child: Text(
                                  snap['productName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Divider(),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "Area Manager Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 2),
                                child: Text(
                                  snap['Area Manager Name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Divider(),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "Area Manager Area",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 2),
                                child: Text(
                                  snap['Area Area'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Divider(),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "Product Dimension",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 2),
                                child: Text(
                                  snap['dimensions'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 20),
                                child: Text(
                                  "Number of Pcs",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 4),
                                child: Text(
                                  snap['PCS'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              ZonalOrderReview(
                                                SalesOfficerName:
                                                    widget.areaname,
                                                productName:
                                                    snap['productName'],
                                                uuid: snap['uuid'],
                                                terirtoryArea:
                                                    snap['Area Area'],
                                                terirtoryName:
                                                    snap['Area Manager Name'],
                                              )));
                                },
                                child: Text('Review'),
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200, 50),
                                    backgroundColor: Colors.purple,
                                    shape: StadiumBorder()),
                              ),
                            )
                          ],
                        );
                      }),
                );
              }
              return Text("data");
            },
          ),
        ],
      ),
    );
  }
}
