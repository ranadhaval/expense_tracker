import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:first_app/model/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class sign_in extends StatefulWidget {
  sign_in({Key? key}) : super(key: key);

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(userref.id);
  }

  final userref = FirebaseFirestore.instance.collection("new_users").doc();
  final formkey = GlobalKey<FormState>();
  var date = DateTime.now();

  bool ok = false;
  String url =
      "https://firebasestorage.googleapis.com/v0/b/miniproject-734e0.appspot.com/o/file%2Fimage_picker6030117152656563326.png%2Ffile?alt=media&token=0a6a47cf-f05b-4bb3-926c-71d511f06a27";
  Create_account() {
    try {
      userref.set({
        "id": userref.id,
        "name": "Default",
        "about": "Default",
        "position": "Default",
        "image": url,
        "email": "${email_controller.text}",
        "time_stamp": "${date.month}/${date.day}/${date.year}",
        "password": "${password_controller.text}"

        // DateTime(
        //     DateTime.now().year, DateTime.now().month, DateTime.now().day),
      });
    } catch (e) {
      print(e);
    }
  }

  fire_auth.FirebaseAuth firebaseAuth = fire_auth.FirebaseAuth.instance;
  TextEditingController password_controller = TextEditingController();
  TextEditingController password_controller2 = TextEditingController();
  TextEditingController email_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: formkey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontStyle: FontStyle.italic))
                  ],
                ),
              ),
              TextFormField(
                autofillHints:[AutofillHints.email],
                onEditingComplete: ()=>TextInput.finishAutofillContext(),
                controller: email_controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) =>
                    val != null && EmailValidator.validate(val) ? null : "empty ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: Text(
                      "  Enter email....",
                      style: TextStyle(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: HexColor("#62d5c4"), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 2))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onEditingComplete: ()=>TextInput.finishAutofillContext(),
                controller: password_controller,
                autofillHints:[ AutofillHints.password],
                obscureText: !ok,
                validator: (val) =>
                    val != null && !val.isEmpty ? null : "empty fields",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ok = !ok;
                          });
                        },
                        icon: ok
                            ? Icon(
                                Icons.visibility,
                                color: Colors.black,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )),
                    prefixIcon: Icon(Icons.password),
                    label: Text(
                      "  Enter Password...",
                      style: TextStyle(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: HexColor("#62d5c4"), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 2))),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: password_controller2,
                autofillHints: [AutofillHints.password],
                onEditingComplete: ()=>TextInput.finishAutofillContext(),
                validator: (val) {
                  if (val!.trim().length < 6) {
                    return "password is too short";
                  } else if (val.isEmpty) {
                    return "password is empty";
                  } else if (val.trim().length > 12) {
                    return "password is too long";
                  } else if (password_controller.text !=
                      password_controller2.text) {
                    return "password not match";
                  }
                  // else if(val.contains('other'))
                  else {
                    return null;
                  }
                },
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    label: Text(
                      "  Renter Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: HexColor("#62d5c4"), width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 2))),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 100,
                child: Card(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () async {
                            final form = formkey.currentState!.validate();
                            if (form) {
                              print("validate");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                ),
                              );
                            }
                            setState(() {
                              circular = true;
                            });
    
                            try {
                              fire_auth.UserCredential userCredential =
                                  await firebaseAuth
                                      .createUserWithEmailAndPassword(
                                          email: email_controller.text,
                                          password: password_controller.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("loogin succesfully")));
                              Create_account();
    
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (Builder) => Home()),
                                  (route) => false);
                              setState(() {
                                circular = false;
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.red,
                              ));
    
                              setState(() {
                                circular = false;
                              });
                            }
    
                            setState(() {
                              circular = true;
                            });
                          },
                          child: circular
                              ? Text("Submit",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic))
                              : CircularProgressIndicator())
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool circular = true;
  void submit() {
    final form = formkey.currentState;

    if (form!.validate()) {
      print(" form validate");
    }
  }
}
