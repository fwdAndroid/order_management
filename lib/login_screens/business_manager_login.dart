import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:order_management/pages/main_business_page.dart';
import 'package:order_management/provider/circular_provider.dart';
import 'package:order_management/widgets/text_form_field_widget.dart';
import 'package:order_management/widgets/utils.dart';
import 'package:provider/provider.dart';

class BussinessManagerLogin extends StatefulWidget {
  String bussines;
  BussinessManagerLogin({Key? key, required this.bussines}) : super(key: key);

  @override
  _BussinessManagerLoginState createState() => _BussinessManagerLoginState();
}

class _BussinessManagerLoginState extends State<BussinessManagerLogin> {
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
    bool wrongEmail = false; // to check if email entered exists
    bool wrongPassword = false; // to check if password entered is correct
    bool emailDisabled = false; // to check if the user is disabled
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/splash.png",
                height: 100,
              ),
              Text(
                "Bussiness Manager Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 20,
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
                        .collection('business')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get()
                        .then(
                          (DocumentSnapshot snapshot) => {
                            print(widget.bussines),
                            if (snapshot.exists)
                              {
                                if (emailController.text.isEmpty ||
                                    passController.text.isEmpty)
                                  {
                                    Customdialog().showInSnackBar(
                                        "Enter Required Fields", context)
                                  }
                                else
                                  {
                                    FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text,
                                    )
                                        .then((value) {
                                      print("object");
                                      Customdialog().showInSnackBar(
                                          "Login Successfully", context);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  MainBusinessPage()));
                                    })
                                  },
                              },
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
        )));
  }
}
