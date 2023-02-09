import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_management/order/distributor_order_detail_page.dart';

class DistributorOrderPage extends StatefulWidget {
  final email, name, area;
  const DistributorOrderPage(
      {Key? key, required this.email, required this.area, required this.name})
      : super(key: key);

  @override
  State<DistributorOrderPage> createState() => _DistributorOrderPageState();
}

class _DistributorOrderPageState extends State<DistributorOrderPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    bool isShowUser = false;
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      searchController.dispose();
    }

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
              .where("Status", isEqualTo: "Active")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children:
                  snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (builder) => DoctorAppointment(
                      //             patientid: FirebaseAuth
                      //                 .instance.currentUser!.uid,
                      //             id: data['uid'],
                      //             likes: data['likes'],
                      //             experience: data['experience'],
                      //             name: data['doctorName'],
                      //             specialization:
                      //                 data['doctorSpecialization'],
                      //             image: data['doctorPhotoURL'],
                      //             address: data['doctorAddres'],
                      //             images: data['doctorCertificationImages'],
                      //             description: data['doctorDesc'])));
                    },
                    title: Row(
                      children: [
                        Text(
                          "Retailer Name:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(data['RetailerName'])),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Retailer Area:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(data['Retailer Area'])),
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
                                      uuid: data['uuid'],
                                    )));
                      },
                      child: Text("View"),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
