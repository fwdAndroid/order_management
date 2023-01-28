import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order_management/pages/main_regional_page.dart';
import 'package:order_management/widgets/text_form_field_widget.dart';
import 'package:order_management/widgets/utils.dart';

class RetailerAppLogin extends StatefulWidget {
  String r = "Retailer";
  RetailerAppLogin({Key? key, required this.r}) : super(key: key);

  @override
  _RetailerAppLoginState createState() => _RetailerAppLoginState();
}

class _RetailerAppLoginState extends State<RetailerAppLogin> {
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
              " Distributer Officer Login",
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
                try {
                  await FirebaseFirestore.instance
                      .collection('retailers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then(
                        (DocumentSnapshot snapshot) => {
                          print(widget.r),
                          if (snapshot.exists)
                            {
                              if (emailController.text.isEmpty ||
                                  passController.text.isEmpty)
                                {
                                  Customdialog().showInSnackBar(
                                      "Enter Required Fields", context)
                                }
                              else if (emailController.text.isNotEmpty &&
                                  passController.text.isNotEmpty)
                                {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text,
                                  )
                                      .then((value) {
                                    Customdialog().showInSnackBar(
                                        "Login Successfully", context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                MainRegionalPage()));
                                  })
                                }
                              else
                                {
                                  Customdialog()
                                      .showInSnackBar("Failed", context),
                                }
                            }
                          else
                            {
                              Customdialog()
                                  .showInSnackBar("Something Wrong", context)
                            }
                        },
                      );
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
