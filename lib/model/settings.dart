import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/model/skip.dart';

import 'package:first_app/personal_info_page.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../feedback.dart';
import '../model/contact_support.dart';
import '../model/forget.dart';
import '../new_edit_profile.dart';

class setting extends StatefulWidget {
  setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((event) {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    user.cancel();
  }

  signout() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  firebaseAuth.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Skip()),
                      (route) => false);
                },
                child: Text("Are you want to Sign out"),
              )
            ],
          );
        });
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: HexColor("#0c1b32"),
        ),
        backgroundColor: HexColor("#0c1b32"),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("new_users")
              .where("email", isEqualTo: '${firebaseAuth.currentUser!.email}')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                  body: Center(child: Text('Something went wrong ')));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  body: Center(
                      child: Text("Loading...",
                          style:
                              TextStyle(color: Colors.black, fontSize: 25))));
            }

            return Scaffold(
              backgroundColor: HexColor("#0c1b32"),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, primary: Colors.transparent),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                    label: Text("")),
                toolbarHeight: 20,
                elevation: 0,
                backgroundColor: HexColor("#0c1b32"),
              ),
              body: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            fontFamily: "Tra",
                            color: Colors.white,
                            fontSize: 40,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.1,
                        width: MediaQuery.of(context).size.width,
                        color:
                            // Colors.amber,
                            HexColor("#0c1b32"),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Column(
                                  children: [
                                    Text(
                                      "Account",
                                      style: TextStyle(
                                        fontFamily: "Tra",
                                        color: Colors.white,
                                        fontSize: 20,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Card(
                                color: HexColor("#0c1b32"),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => Personal(
                                                pass: "${data['password']}",
                                                email: '${data['email']}',
                                                image: '${data['image']}',
                                                name: '${data['name']}',
                                                time:
                                                    '${data['time_stamp']}')));
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.amber,
                                        backgroundImage:
                                            NetworkImage(data['image']),
                                        radius: 35,
                                      ),
                                    ),
                                    title: Text(
                                      data['name'],
                                      style: TextStyle(
                                        fontFamily: "Tra",
                                        color: Colors.white,
                                        fontSize: 20,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      "personal info",
                                      style: TextStyle(
                                        fontFamily: "Tra",
                                        color: Colors.grey,
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    trailing: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListTile(
                                leading: Column(
                                  children: [
                                    Text(
                                      "Settings",
                                      style: TextStyle(
                                        fontFamily: "Tra",
                                        color: Colors.white,
                                        fontSize: 20,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                elevation: 0,
                                color: HexColor("#0c1b32"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: HexColor("#0c1b32"))),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => Edits(
                                                    join: data['time_stamp'],
                                                    id: data['id'],
                                                    email: data['email'],
                                                    image: data['image'],
                                                    name: data['name'],
                                                    position: data['position'],
                                                    pass: data['password'],
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.amber.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      title: Text(
                                        "Edit profile",
                                        style: TextStyle(
                                            fontFamily: "Tra",
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 0,
                                color: HexColor("#0c1b32"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: HexColor("#0c1b32"))),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) =>
                                                  fedback(data['id'])));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.greenAccent
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Icon(
                                          Icons.feedback_outlined,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                      title: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      fedback(data['id'])));
                                        },
                                        child: Text(
                                          "Feedback",
                                          style: TextStyle(
                                              fontFamily: "Tra",
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      trailing: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 0,
                                color: HexColor("#0c1b32"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: HexColor("#0c1b32"))),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => forget()));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Icon(
                                          Icons.lock_reset_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => forget()));
                                        },
                                        child: Text(
                                          "Change password",
                                          style: TextStyle(
                                              fontFamily: "Tra",
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      trailing: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 0,
                                color: HexColor("#0c1b32"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: HexColor("#0c1b32"))),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      signout();
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Icon(
                                          Icons.exit_to_app,
                                          color: Colors.red,
                                        ),
                                      ),
                                      title: Text(
                                        "signout",
                                        style: TextStyle(
                                            fontFamily: "Tra",
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 0,
                                color: HexColor("#0c1b32"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: HexColor("#0c1b32"))),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => c_s()));
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Icon(
                                          Icons.contact_support,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        "Contact and Support",
                                        style: TextStyle(
                                            fontFamily: "Tra",
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Icon(Icons.arrow_forward_ios,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ));
  }


}
