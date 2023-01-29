import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:order_management/model/orders_model.dart';
import 'package:uuid/uuid.dart';

class Database {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> addOrder(
      {required String rate,
      required String RName,
      required String productname,
      required String dimension,
      required String pcs,
      String? DName,
      String? distributorid,
      String? Status,
      String? retailerarea,
      String? distributorarea}) async {
    String res = 'Some error occured';

    try {
      var uuid = Uuid().v1();

      OrderModel userModel = OrderModel(
        teritoryArea: '',
        areamanager: '',
        busnissarea: '',
        Status: Status,
        regionalarea: '',
        retailerarea: retailerarea,
        zonalarea: '',
        salesaofficerarea: '',
        distributorarea: distributorarea,
        distributorid: distributorid,
        tName: '',
        AName: '',
        bName: '',
        REName: '',
        RName: RName,
        ZName: '',
        SName: '',
        DName: DName,
        uuid: uuid,
        pcs: pcs,
        productName: productname,
        dimensions: dimension,
        rate: rate,
      );
      await firebaseFirestore
          .collection('orders')
          .doc(uuid)
          .set(userModel.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
