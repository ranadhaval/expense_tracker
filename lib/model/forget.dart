import 'package:first_app/model/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class forget extends StatefulWidget {
  forget({Key? key}) : super(key: key);

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  String email = "";
  fire_auth.FirebaseAuth firebaseAuth = fire_auth.FirebaseAuth.instance;
  bool circular = true;
  final formkey = GlobalKey<FormState>();
  TextEditingController email_controller = TextEditingController();

  Future password_reset() async {
    setState(() {
      email = email_controller.text;
    });
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email_controller.text);
      final snackBar =
          SnackBar(content: Text("Password reset email sent to the  $email"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            // actions: [

            //   Icon(
            //     Icons.exit_to_app,
            //     color: Colors.white,
            //   )
            // ],
            title: Center(
                child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 45,
                ),
                Text(
                  "Password Reset",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )),
            backgroundColor: Colors.black,
          ),
          body: Material(
            child: Form(
              key: formkey,
              child: Container(
                color: Colors.grey.withOpacity(0.2),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.white)),
                            height: 200,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage("Assets/images/new.png")),
                            ),
                          ),
                        ),
                    

 Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Expense Tracker",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontFamily: "Tra",
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

  SizedBox(
                        height: 20,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Password Reset here",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextFormField(
                          controller: email_controller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) =>
                              val != null && EmailValidator.validate(val)
                                  ? null
                                  : "wrong inputed text",
                                  
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontStyle: FontStyle.italic),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              label: Text(
                                "  Enter email....",
                                style: TextStyle(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: password_reset,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 100,
                          child: Card(
                            color: Colors.black,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                circular
                                    ? Text("Submit",
                                        style: TextStyle(
                                            letterSpacing: 1,
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic))
                                    : CircularProgressIndicator()
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
