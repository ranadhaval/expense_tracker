// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class Home2 extends StatefulWidget {
  Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _HomeState();
}

class _HomeState extends State<Home2> {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("new_users");
  Future<void> delete_user(id) {
    return reference.doc(id).delete().then((val) {
      print("deleted succesfully");
    }).catchError((e) {
      print(e);
    });
  }

  fire_auth.FirebaseAuth _firebaseAuth = fire_auth.FirebaseAuth.instance;
  Future<void> add_user() {
    return reference.doc().set(
        {"age": "56", "position": "student", "name": "dhaval"}).then((val) {
      print("deleted succesfully");
    }).catchError((e) {
      print(e);
    });
  }

// fire_auth.UserCredential
  // late User user;
  Future<void> update(id) {
    return reference.doc(id).update({
      "age": "new_age",
      'name': fire_auth.UserCredential,
    });
  }

// final Future<User> user1 = FirebaseAuth.currentUser();
  final Stream<QuerySnapshot> student =
      FirebaseFirestore.instance.collection("new_users").snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('new_users')
            .doc("")
            .collection('address')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> orderSnapshot) {
          return orderSnapshot.hasData
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: orderSnapshot.data!.docs
                      .map((DocumentSnapshot documentSnapshot) {
                    Map data = documentSnapshot.data() as Map<String, dynamic>;
                    // print(documentSnapshot.id);

                    data['id'] = documentSnapshot.id;

                    return Container(
                      padding: EdgeInsets.all(5),
                      height: 120,
                      width: MediaQuery.of(context).size.width - 10,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['name'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  width: 37,
                                ),
                                InkWell(
                                    onTap: () {
                                      update(data['id']);
                                    },
                                    child: Icon(Icons.edit)),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['age'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  width: 55,
                                ),
                                InkWell(
                                    onTap: () {
                                      delete_user(data['id']);
                                    },
                                    child: Icon(Icons.delete))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data['position'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 25),
                                ),
                                InkWell(
                                    onTap: () {
                                      add_user();
                                    },
                                    child: Icon(Icons.add))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )
              : CircularProgressIndicator();
        });
  }
}
