import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class fedback extends StatefulWidget {
  // fedback({Key? key}) : super(key: key);

  String id;
  fedback(this.id);

  @override
  State<fedback> createState() => _forgetState();
}

class _forgetState extends State<fedback> {
  String email = "";
  fire_auth.FirebaseAuth firebaseAuth = fire_auth.FirebaseAuth.instance;
  bool circular = true;
  final formkey = GlobalKey<FormState>();
  TextEditingController email_controller = TextEditingController();

  Future<Future<DocumentReference<Map<String, dynamic>>>> add() async {
    var reference2 = FirebaseFirestore.instance
        .collection('new_users')
        .doc("${widget.id}")
        .collection("feedback");

    return reference2.add({
      "Address": "${email_controller.text}",
    });
  }

  submit() {
    try {
      add();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Thanks for feedback"),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$e"),
        backgroundColor: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
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
                  "Feedback",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            )),
            backgroundColor: HexColor("#0c1b32"),
          ),
          body: Material(
            child: Form(
              key: formkey,
              child: Container(
                color: HexColor("#0c1b32"),
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
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Expense Tracker",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
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
                              "Give your Feedback",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 7,
                        width: MediaQuery.of(context).size.width - 40,
                        child: TextFormField(
                          controller: email_controller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => val != null && !val.isEmpty
                              ? null
                              : "wrong inputed text",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "Tra"),
                          decoration: InputDecoration(
                              label: Text(
                                "  Enter your feedback",
                                style: TextStyle(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: HexColor("#62d5c4"), width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: submit,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 100,
                          child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.white)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                circular
                                    ? Text("Submit",
                                        style: TextStyle(
                                          fontFamily: "Tra",
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
