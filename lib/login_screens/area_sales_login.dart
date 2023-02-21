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
  bool _isHidden = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.clear();
    passController.clear();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      key: _scaffoldKey,
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
                if (emailController.text.isEmpty &&
                    passController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("email and password is missing"),
                    duration: Duration(seconds: 2),
                  ));
                } else if (emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("email is required"),
                    duration: Duration(seconds: 2),
                  ));
                } else if (passController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("password is required"),
                    duration: Duration(seconds: 2),
                  ));
                } else {
                  loginUser();
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

  void loginUser() async {
    try {
      await FirebaseFirestore.instance
          .collection("usersmanagers")
          .get()
          .then((QuerySnapshot snapshot) {
        print("sad");
        snapshot.docs.forEach((element) {
          if (element['password'] == passController.text &&
              element['email'] == emailController.text &&
              element['type'] == widget.area) {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
              email: emailController.text,
              password: passController.text,
            )
                .then((value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => MainAreaPage()),
                  (route) => false);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Login Complete")));
            });
          } else {
            print("nothing");
            // Customdialog().showInSnackBar(
            //     "email or password may be wrong please rewrite it", context);
          }
        });
      });
    } catch (e) {}
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
