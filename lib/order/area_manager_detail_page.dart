import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:order_management/database/db.dart';
import 'package:order_management/review/area_order_review.dart';
import 'package:order_management/review/distributor_order_review.dart';
import 'package:order_management/review/sales_officer_order_review.dart';
import 'package:order_management/review/territory_order_review.dart';
import 'package:order_management/widgets/utils.dart';

class AreaManagerDetailPage extends StatefulWidget {
  final String areaarea, areaemail, areaname, uuid;
  const AreaManagerDetailPage({
    super.key,
    required this.uuid,
    required this.areaarea,
    required this.areaname,
    required this.areaemail,
  });

  @override
  State<AreaManagerDetailPage> createState() => _AreaManagerDetailPageState();
}

class _AreaManagerDetailPageState extends State<AreaManagerDetailPage> {
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
        title: Text("Area Manager Order Page"),
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
                .where("uuid", isEqualTo: widget.uuid)
                .where("Area Manager Name", isEqualTo: widget.areaname)
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
                                  "Territory Manager Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 2),
                                child: Text(
                                  snap['Territory Manager Name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Divider(),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text(
                                  "Territory Manager Area",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 2),
                                child: Text(
                                  snap['Territory Area'],
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
                            // Container(
                            //     margin: EdgeInsets.only(
                            //         left: 15, right: 15, top: 20),
                            //     child: Text(
                            //       "Number of Pcs",
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w700,
                            //           fontSize: 17),
                            //     )),
                            // Container(
                            //     margin: EdgeInsets.only(
                            //         left: 15, right: 15, top: 4),
                            //     child: Text(
                            //       snap['PCS'],
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w700,
                            //           fontSize: 17),
                            //     )),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => AreaOrderReview(
                                                SalesOfficerName:
                                                    widget.areaname,
                                                productName:
                                                    snap['productName'],
                                                uuid: snap['uuid'],
                                                terirtoryArea:
                                                    snap['Territory Area'],
                                                terirtoryName: snap[
                                                    'Territory Manager Name'],
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
