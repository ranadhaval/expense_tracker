import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/settings.dart';
class Profile_ui extends StatefulWidget {
  Profile_ui({Key? key}) : super(key: key);

  @override
  State<Profile_ui> createState() => _Profile_uiState();
}

class _Profile_uiState extends State<Profile_ui> {
  String st = "Eating";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.grey,
          //   elevation: 0,
          // ),
          body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("new_users")
            .where("email", isEqualTo: '${firebaseAuth.currentUser!.email}')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          ScreenUtil.init(context);
          if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Something went wrong ')));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
                    child: Text("Loading...",
                        style: TextStyle(color: Colors.black, fontSize: 25))));
          }

          return Scaffold(
            backgroundColor: HexColor("#0c1b32"),
            appBar: AppBar(
              toolbarHeight: 0,
              elevation: 0,
              backgroundColor: HexColor("#0c1b32"),
            ),
            body: ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1),
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("Profile",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),

                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Profile",
                                      style: TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),

                              // SizedBox(
                              //   height: 10,
                              // ),
                              ListTile(
                                leading: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['image']),
                                    radius: 30,
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
                                  data['position'],
                                  style: TextStyle(
                                      fontFamily: "Tra",
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // padding: EdgeInsets.all(10),
                      // margin: EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height / 1.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              // topLeft: Radius.circular(30),
                              // topRight: Radius.circular(30)

                              )),

                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (_) => setting(),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Text(
                                    "Settings",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (st == "Vehicle") {
                                        st = "Eating";
                                      } else {
                                        st = "Vehicle";
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Recently added",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.grey.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              // alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2))),
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {},
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                20,
                                            child: ListView(
                                              children: [
                                                
                                                StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('new_users')
                                                        .doc(data['id'])
                                                        .collection('address')
                                                        .orderBy("Time",
                                                            descending: false)
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            orderSnapshot) {
                                                      return orderSnapshot
                                                              .hasData
                                                          ? Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: orderSnapshot
                                                                  .data!.docs
                                                                  .map((DocumentSnapshot
                                                                      documentSnapshot2) {
                                                                Map data2 = documentSnapshot2
                                                                        .data()
                                                                    as Map<
                                                                        String,
                                                                        dynamic>;

                                                                data2['id'] =
                                                                    documentSnapshot2
                                                                        .id;

                                                                return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          5.0),
                                                                  child: Card(
                                                                    elevation:
                                                                        10,
                                                                    color: Colors
                                                                        .white,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              10),
                                                                      height:
                                                                          100.h,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width -
                                                                          20,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          border:
                                                                              Border.all(color: Colors.black)),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            ListTile(
                                                                              title: Container(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      data2['Title'],
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              subtitle: Text(data2['value']),
                                                                              leading: Container(
                                                                                padding: EdgeInsets.all(3),
                                                                                height: 60,
                                                                                width: 60,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.blue.withOpacity(0.8))),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "${data2['icon']}",
                                                                                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                                                                                )),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  FittedBox(
                                                                                    child: Text(
                                                                                      "Time: ${data2['Time']}",
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            )
                                                          : Center(
                                                              child:
                                                                  Lottie.asset(
                                                              "Assets/jj.json",
                                                            ));
                                                    })
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
          );
        },
      )),
    );
  }
}
