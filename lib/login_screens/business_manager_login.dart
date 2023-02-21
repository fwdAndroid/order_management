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
  bool _isHidden = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/splash.png",
                height: 200,
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
              TextField(
                controller: passController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isHidden,
                decoration: InputDecoration(
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: EdgeInsets.all(8),
                  fillColor: Colors.white,
                  hintText: 'Password',
                  suffix: InkWell(
                    onTap: _togglePasswordView,
                    child: Icon(
                      _isHidden ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
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
                        .collection("usersmanagers")
                        .get()
                        .then((QuerySnapshot snapshot) {
                      print("sad");
                      snapshot.docs.forEach((element) {
                        if (element['password'] == passController.text &&
                            element['email'] == emailController.text &&
                            element['type'] == widget.bussines) {
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
                              Customdialog().showInSnackBar(
                                  "Login Successfullt", context);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MainBusinessPage()),
                                  (route) => false);
                            });
                          }
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
        )));
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
