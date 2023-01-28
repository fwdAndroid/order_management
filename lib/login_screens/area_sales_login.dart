import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_management/pages/main_area_page.dart';
import 'package:order_management/widgets/text_form_field_widget.dart';
import 'package:order_management/widgets/utils.dart';

class AreaSales extends StatefulWidget {
  String area = "AreaManager";
  AreaSales({Key? key, required this.area}) : super(key: key);

  @override
  _AreaSalesState createState() => _AreaSalesState();
}

class _AreaSalesState extends State<AreaSales> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash.png",
              height: 200,
            ),
            Text(
              "Area Sales Manager Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormInputField(
              hintText: 'Enter youe email',
              textInputType: TextInputType.emailAddress,
              controller: emailController,
            ),
            SizedBox(
              height: 23,
            ),
            TextFormInputField(
              hintText: 'Enter youe password',
              textInputType: TextInputType.visiblePassword,
              controller: passController,
              isPass: true,
            ),
            SizedBox(
              height: 23,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  fixedSize: Size(300, 50),
                  shape: StadiumBorder()),
              onPressed: () async {
                print("Print");
                try {
                  await FirebaseFirestore.instance
                      .collection("areas")
                      .get()
                      .then((QuerySnapshot snapshot) {
                    print("sad");
                    snapshot.docs.forEach((element) {
                      if (element['password'] == passController.text &&
                          element['email'] == emailController.text &&
                          element['type'] == widget.area) {
                        if (emailController.text.isEmpty ||
                            passController.text.isEmpty) {
                          Customdialog().showInSnackBar(
                              "Email and Password is needed", context);
                        } else {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text,
                          )
                              .then((value) {
                            Customdialog()
                                .showInSnackBar("Login Successfullt", context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => MainAreaPage()),
                                (route) => false);
                          });
                        }
                        Customdialog()
                            .showInSnackBar("Login Successfullt", context);
                      } else {
                        Customdialog().showInSnackBar("wrong", context);
                      }
                    });
                  });
                } catch (e) {
                  Customdialog().showInSnackBar(e.toString(), context);
                }
              },
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            SizedBox(
              height: 13,
            ),
          ],
        ),
      )),
    );
  }

  void loginUser() {}
}
