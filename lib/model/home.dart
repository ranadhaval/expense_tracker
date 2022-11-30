import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/main.dart';
import 'package:first_app/model/add.dart';

import 'package:first_app/model/nn.dart';
import 'package:first_app/model/view_doc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:first_app/profile_ui.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'epense_edit.dart';

final userref = FirebaseFirestore.instance.collection("new_users").doc();

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String hh = "";
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      setState(() {
        hh = "😎 Good Morning";
        print(timeNow);
      });
      return '😎 Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      setState(() {
        hh = "😎 Good Afternoon";
      });
      return '😎 Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      setState(() {
        hh = "😎 Good Evening";
      });
      return '😎 Good Evening';
    } else {
      setState(() {
        hh = "Good Night 😴";
      });
      return 'Good Night😪';
    }
  }

  bool online_pay = true;
  bool offline_pay = true;
  bool pending_pay = true;

  String payment = "";

  // List<Mymodel> my_list = [];

  late Stream<QuerySnapshot<Map<String, dynamic>>> datag;
  @override
  void initState() {
    super.initState();
    greetingMessage();
    datag = my_data();
    // FirebaseFirestore.instance.collection("").get().then((value) {
    //   value.docs.forEach((element) {
    //     my_list.insert(
    //         0, Mymodel(hh: element.get("hh"), num: element.get("num")));
    //   });
    // });

    // FirebaseFirestore.instance
    //     .collection("doc")
    //     .get()
    //     .then((QuerySnapshot querysnapshot) {
    //   querysnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
    //     print(documentSnapshot.data());
    //     // my_list.add({});
    //   });
    // });

    // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> my_data() {
    return 
   FirebaseFirestore.instance
          .collection("new_users")
          .where("email", isEqualTo: '${firebaseAuth.currentUser!.email}')
          .snapshots()
    
    ;
  }

  edit(String id2) {
    setState(() {
      Navigator.pop(context);
    });
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => edit_post(id2)), (route) => true);
  }

  select_image(ParentContext, String id1, String id2) {
    return showDialog(
        context: ParentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose option"),
            children: [
              SimpleDialogOption(
                child: Text("Edit Your Expense"),
                onPressed: () {
                  edit(id2);

                  // Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text("Delete your Expense"),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('new_users')
                      .doc(id1)
                      .collection('address')
                      .doc(id2)
                      .delete()
                      .catchError((e) {
                    print(e);
                  });

                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text("Cancle"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<Future<DocumentReference<Map<String, dynamic>>>> add(String id) async {
    var reference2 = FirebaseFirestore.instance
        .collection('new_users')
        .doc(id)
        .collection("address");
    print(userref.id);
    return reference2.add({'name': "dhaval rana", "position": "student"});
  }

  Future<void> update(id, id2) {
    return FirebaseFirestore.instance
        .collection('new_users')
        .doc(id)
        .collection('address')
        .doc(id2)
        .update({'name': 'bilionair_dhaval', 'position': 'ownwer'}).catchError(
            (e) {
      print(e);
      print("data is as ");
      print(id);
      print(id2);
    });
  }

// important

  Future<void> delete(id, id2) {
    return FirebaseFirestore.instance
        .collection('new_users')
        .doc(id)
        .collection('address')
        .doc(id2)
        .delete()
        .catchError((e) {
      print(e);
      print("data is as ");
      print(id);
      print(id2);
    });
  }

  bool All = true;
  bool Home_eX = true;
  bool Clothes = true;
  bool cable = true;
  bool shopping = true;
  bool travel = true;
  bool vehicle = true;
  bool Eating = true;
  bool Others = true;
  bool offline = true;
  bool online = true;
  bool pending = true;
  bool pen = true;

  bool All_new = true;
  bool categories_new = true;
  String category = "";
  String payment_method = "";
  bool dd = true;
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        ScreenUtil.init(
          context,
        );

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
                body: Center(
              child: Text("no data found yet !"),
            )),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: HexColor("#0c1b32"),
              body:
                  Center(child: Lottie.asset("Assets/jj.json", animate: true)));
        }

        return Scaffold(
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.black,
              overlayColor: Colors.black,
              spaceBetweenChildren: 10,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.add),
                  backgroundColor: Colors.red,
                  label: "Add",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Add()));
                  },
                ),
                SpeedDialChild(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (builder) => j()));
                  },
                  child: Icon(Icons.bar_chart_rounded),
                  backgroundColor: Colors.green,
                  label: "analys",
                ),
                SpeedDialChild(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Profile_ui()));
                  },
                  child: Icon(Icons.person),
                  backgroundColor: Colors.orange,
                  label: "profile",
                ),
              ],
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 200,
              elevation: 0,
              backgroundColor: HexColor("#0c1b32"),
              title: Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            // padding: EdgeInsets.all(1),
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  tileColor: HexColor("#0c1b32"),
                                  trailing: Container(
                                    width: 50,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: HexColor("#0c1b32"),
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image(
                                        image: NetworkImage(data['image'])),
                                  ),
                                  selectedTileColor: HexColor("#0c1b32"),
                                  title: Text(" $hh \n \t${data['name']} 👋  ",
                                      style: TextStyle(
                                          fontFamily: "Tra",
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: HexColor("#0c1b32"),
                                    child: ListTile(
                                      title: Text(" \n${data['about']}",
                                          style: TextStyle(
                                              fontFamily: "Tra",
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            body: Scaffold(
              backgroundColor: HexColor("#0c1b32"),
              appBar: AppBar(
                toolbarHeight: 0,
                elevation: 0,
                backgroundColor: HexColor("#0c1b32"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    return Column(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.all(2),
                              // margin: EdgeInsets.all(10),
                              height: MediaQuery.of(context).size.height / 1.2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      // topLeft: Radius.circular(30),
                                      // topRight: Radius.circular(30)
                                      )),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ff(),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            color: Colors.grey.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2 /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(children: [
                                            Container(
                                              width: 160.w,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: All_new
                                                            ? Colors.black
                                                            : Colors
                                                                .transparent,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                    "All",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                  ))),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 153.w,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                onTap: () {
                                                  setState(() {
                                                    if (categories_new ==
                                                        true) {
                                                      categories_new = false;
                                                      All_new = false;
                                                    } else {
                                                      categories_new = true;
                                                      All_new = true;
                                                    }
                                                  });

                                                  // setState(() {

                                                  //   jj = true;

                                                  // });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: categories_new
                                                              ? Colors
                                                                  .transparent
                                                              : Colors.black,
                                                          width: 2),
                                                      borderRadius:
                                                          categories_new
                                                              ? BorderRadius
                                                                  .circular(10)
                                                              : BorderRadius
                                                                  .circular(5),
                                                      color: Colors.white,
                                                    ),
                                                    height: 50.h,
                                                    width: 165.w,
                                                    child: Center(
                                                        child: Text(
                                                      "Categories",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    ))),
                                              ),
                                            ),
                                          ]),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.9,
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      child: ListView(
                                        children: [
                                          categories_new
                                              ? StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('new_users')
                                                      .doc(data['id'])
                                                      .collection('address')
                                                      .snapshots(),
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              QuerySnapshot>
                                                          orderSnapshot) {
                                                    return orderSnapshot.hasData
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
                                                              Map data2 =
                                                                  documentSnapshot2
                                                                          .data()
                                                                      as Map<
                                                                          String,
                                                                          dynamic>;

                                                              data2['id'] =
                                                                  documentSnapshot2
                                                                      .id;

                                                              return SingleChildScrollView(
                                                                  child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            5.0),
                                                                    child: InkWell(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        onLongPress: () {
                                                                          setState(
                                                                              () {
                                                                            if (dd ==
                                                                                true) {
                                                                              dd = false;
                                                                            } else {
                                                                              dd = true;
                                                                            }
                                                                          });
                                                                        },
                                                                        child: Card(
                                                                          elevation:
                                                                              10,
                                                                          color:
                                                                              Colors.white,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.all(10),
                                                                            height:
                                                                                140.h,
                                                                            width:
                                                                                MediaQuery.of(context).size.width - 20,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                border: Border.all(color: Colors.black)),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Column(
                                                                                children: [
                                                                                  ListTile(
                                                                                    trailing: InkWell(
                                                                                        onTap: () {
                                                                                          select_image(context, data['id'], data2['id']);
                                                                                        },
                                                                                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red.withOpacity(0.2), border: Border.all(color: Colors.grey)), child: Icon(Icons.settings))),
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
                                                                                      height: 60,
                                                                                      width: 50,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.blue.withOpacity(0.8))),
                                                                                      child: Center(
                                                                                          child: Text(
                                                                                        data2['icon'],
                                                                                        style: TextStyle(fontSize: 27),
                                                                                      )),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        FittedBox(
                                                                                          child: Text(
                                                                                            "Adress: ${data2['Address']}",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 3,
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
                                                                                  SizedBox(
                                                                                    height: 3,
                                                                                  ),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.push(context, MaterialPageRoute(builder: (_) => doc_view(data2['doc'])));
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Container(
                                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black)),
                                                                                              height: 20,
                                                                                              width: 50,
                                                                                              child: Center(
                                                                                                  child: InkWell(
                                                                                                      onTap: () {
                                                                                                        Navigator.push(context, MaterialPageRoute(builder: (_) => doc_view(data2['doc'])));
                                                                                                      },
                                                                                                      child: Text(
                                                                                                        "doc",
                                                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                                                                                      )))),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )),
                                                                  )
                                                                ],
                                                              ));
                                                            }).toList(),
                                                          )
                                                        : Center(
                                                            child: Lottie.asset(
                                                            "Assets/jj.json",
                                                          ));
                                                  })
                                              : StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection('new_users')
                                                      .doc(data['id'])
                                                      .collection('address')
                                                      .where(
                                                        "category",
                                                        isEqualTo:
                                                            "${category}",
                                                      )
                                                      .snapshots(),
                                                  builder: (context,
                                                      AsyncSnapshot<
                                                              QuerySnapshot>
                                                          orderSnapshot) {
                                                    return orderSnapshot.hasData
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
                                                              Map data2 =
                                                                  documentSnapshot2
                                                                          .data()
                                                                      as Map<
                                                                          String,
                                                                          dynamic>;

                                                              data2['id'] =
                                                                  documentSnapshot2
                                                                      .id;

                                                              return SingleChildScrollView(
                                                                  child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
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
                                                                        margin:
                                                                            EdgeInsets.all(10),
                                                                        height:
                                                                            130,
                                                                        width: MediaQuery.of(context).size.width -
                                                                            20,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            border: Border.all(color: Colors.black)),
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
                                                                                  height: 60,
                                                                                  width: 50,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.blue.withOpacity(0.8))),
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    data2['icon'],
                                                                                    style: TextStyle(fontSize: 27),
                                                                                  )),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    FittedBox(
                                                                                      child: Text(
                                                                                        "Adress: ${data2['Address']}",
                                                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              // SizedBox(
                                                                              //   height: 4,
                                                                              // ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(4.0),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black)),
                                                                                        height: 20,
                                                                                        width: 30,
                                                                                        child: Center(
                                                                                            child: InkWell(
                                                                                                onTap: () {
                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => doc_view(data2['doc'])));
                                                                                                },
                                                                                                child: Text(
                                                                                                  "doc",
                                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                                                                                )))),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ));
                                                            }).toList(),
                                                          )
                                                        : Text(
                                                            "Loading...",
                                                            style: TextStyle(
                                                                fontSize: 30),
                                                          );
                                                  }),
                                          SizedBox(
                                            height: 100,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    FittedBox(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black),
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(children: [
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: 100.w,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    setState(() {
                                                      if (online_pay == true) {
                                                        online_pay = false;
                                                        offline_pay = true;
                                                        pending_pay = true;
                                                        payment_method =
                                                            "online";
                                                      } else {
                                                        payment_method = "";
                                                        online_pay = true;
                                                      }
                                                      print(payment_method);
                                                      print(online_pay);
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: online_pay
                                                                ? Colors
                                                                    .transparent
                                                                : Colors.black,
                                                            width: 2),
                                                        borderRadius: online_pay
                                                            ? BorderRadius
                                                                .circular(10)
                                                            : BorderRadius
                                                                .circular(5),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "online",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ))),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 100.w,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    setState(() {
                                                      if (offline_pay == true) {
                                                        payment_method =
                                                            "offline";
                                                        offline_pay = false;
                                                        online_pay = true;
                                                        pending_pay = true;
                                                      } else {
                                                        payment_method = "";
                                                        offline_pay = true;
                                                      }
                                                      print(payment_method);
                                                      print(offline_pay);
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: offline_pay
                                                                ? Colors
                                                                    .transparent
                                                                : Colors.black,
                                                            width: 2),
                                                        borderRadius:
                                                            offline_pay
                                                                ? BorderRadius
                                                                    .circular(
                                                                        10)
                                                                : BorderRadius
                                                                    .circular(
                                                                        5),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                          child: Text(
                                                        "offline",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ))),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 100.w,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    setState(() {
                                                      if (pending_pay == true) {
                                                        payment_method =
                                                            "pending";
                                                        pending_pay = false;
                                                        online_pay = true;
                                                        offline_pay = true;
                                                      } else {
                                                        payment_method = "";
                                                        pending_pay = true;
                                                      }
                                                      print(payment_method);
                                                      print(pending_pay);
                                                    });
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: pending_pay
                                                                  ? Colors
                                                                      .transparent
                                                                  : Colors
                                                                      .black,
                                                              width: 2),
                                                          borderRadius:
                                                              pending_pay
                                                                  ? BorderRadius
                                                                      .circular(
                                                                          10)
                                                                  : BorderRadius
                                                                      .circular(
                                                                          5),
                                                          color: Colors.white),
                                                      child: Center(
                                                          child: Text(
                                                        "pending",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10),
                                                      ))),
                                                ),
                                              ),
                                            ]),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber.withOpacity(0.2),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      child: ListView(
                                        children: [
                                          StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('new_users')
                                                  .doc(data['id'])
                                                  .collection('address')
                                                  .where(
                                                    "payment_method",
                                                    isEqualTo:
                                                        "${payment_method}",
                                                  )
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<QuerySnapshot>
                                                      orderSnapshot) {
                                                return orderSnapshot.hasData
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
                                                          Map data2 =
                                                              documentSnapshot2
                                                                      .data()
                                                                  as Map<String,
                                                                      dynamic>;

                                                          data2['id'] =
                                                              documentSnapshot2
                                                                  .id;

                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Card(
                                                              elevation: 10,
                                                              color:
                                                                  Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                height: 130,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    20,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .black)),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Column(
                                                                    children: [
                                                                      ListTile(
                                                                        title:
                                                                            Container(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                data2['Title'],
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        subtitle:
                                                                            Text(data2['value']),
                                                                        leading:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(3),
                                                                          height:
                                                                              60,
                                                                          width:
                                                                              60,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              border: Border.all(color: Colors.blue.withOpacity(0.8))),
                                                                          child: Center(
                                                                              child: Text(
                                                                            "${data2['payment_method']}",
                                                                            style:
                                                                                TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                                          )),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            FittedBox(
                                                                              child: Text(
                                                                                "Adress: ${data2['Address']}",
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      // SizedBox(
                                                                      //   height: 4,
                                                                      // ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black)),
                                                                                height: 20,
                                                                                width: 30,
                                                                                child: Center(
                                                                                    child: InkWell(
                                                                                        onTap: () {
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (_) => doc_view(data2['doc'])));
                                                                                        },
                                                                                        child: Text(
                                                                                          "doc",
                                                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                                                                        )))),
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
                                                        child: Lottie.asset(
                                                        "Assets/jj.json",
                                                      ));
                                              })
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 180,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ));
      }),
      stream: datag,
    );
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ffc(String money, String time, String mode) {
    return ListTile(
      title: Text(money),
      subtitle: Text(time),
      trailing: Text(mode),
    );
  }

  BuildContext get context;

  ff() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 165.h,
        width: 440.w,
        // width: MediaQuery.of(context).size.width - 40.w,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (All == true) {
                        category = "All";
                        print(category);
                        All = false;
                      } else {
                        category = "";
                        print(category);
                        All = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: All
                                  ? Colors.transparent
                                  : Colors.black.withOpacity(0.1),
                              width: 2),
                          borderRadius: All
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(15),
                          color: All
                              ? Colors.blue.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.2),
                        ),
                        height: 50,
                        width: 100.w,
                        child: Center(
                            child: Text(
                          "All",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (Home_eX == true) {
                        category = "Home Expense";
                        print(category);
                        Home_eX = false;
                      } else {
                        category = "";
                        print(category);
                        Home_eX = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Home_eX ? Colors.transparent : Colors.teal,
                            width: 2),
                        borderRadius: Home_eX
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(15),
                        color: Home_eX
                            ? Colors.teal.withOpacity(0.2)
                            : Colors.teal.withOpacity(0.2),
                      ),
                      height: 50,
                      width: 100.w,
                      child: Center(
                          child: Text(
                        "⛪ Home Expense ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11),
                      ))),
                ),
                SizedBox(
                  width: 7,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (Clothes == true) {
                        category = "Clothes - Shoes";
                        print(category);
                        Clothes = false;
                      } else {
                        category = "";
                        print(category);
                        Clothes = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Clothes ? Colors.transparent : Colors.pink,
                            width: 2),
                        borderRadius: Clothes
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(15),
                        color: Clothes
                            ? Colors.pink.withOpacity(0.2)
                            : Colors.pink.withOpacity(0.2),
                      ),
                      height: 50,
                      width: 110.w,
                      child: Center(
                          child: Text(
                        "🥼👞 Clothes - Shoes",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ))),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (cable == true) {
                        category = "Cable-Tv";
                        print(category);
                        cable = false;
                      } else {
                        category = "";
                        print(category);
                        cable = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: cable ? Colors.transparent : Colors.grey,
                              width: 2),
                          borderRadius: cable
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(15),
                          color: cable
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.2),
                        ),
                        height: 50,
                        width: 100.w,
                        child: Center(
                            child: Text(
                          "🔌📺  Cable-Tv",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ))),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (shopping == true) {
                        category = "Shopping";
                        print(category);
                        shopping = false;
                      } else {
                        category = "";
                        print(category);
                        shopping = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  shopping ? Colors.transparent : Colors.amber,
                              width: 2),
                          borderRadius: shopping
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(15),
                          color: shopping
                              ? Colors.amber.withOpacity(0.2)
                              : Colors.amber.withOpacity(0.2),
                        ),
                        height: 50,
                        width: 100.w,
                        child: Center(
                            child: Text(
                          "🛒 Shopping",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ))),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (travel == true) {
                        category = "travel";
                        print(category);
                        travel = false;
                      } else {
                        category = "";
                        print(category);
                        travel = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: travel ? Colors.transparent : Colors.green,
                              width: 2),
                          borderRadius: travel
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(15),
                          color: travel
                              ? Colors.green.withOpacity(0.2)
                              : Colors.green.withOpacity(0.2),
                        ),
                        height: 50,
                        width: 110.w,
                        child: Center(
                            child: Text(
                          "🚆✈ travel",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ))),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (vehicle == true) {
                        category = "Vehicle";
                        print(category);
                        vehicle = false;
                      } else {
                        category = "";
                        print(category);
                        vehicle = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: vehicle ? Colors.transparent : Colors.blue,
                            width: 2),
                        borderRadius: vehicle
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(15),
                        color: vehicle
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.2),
                      ),
                      height: 50,
                      width: 100.w,
                      child: Center(
                          child: Text(
                        "🛺🚗 Vehicle",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11),
                      ))),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (Eating == true) {
                        category = "Eating";
                        print(category);
                        Eating = false;
                      } else {
                        category = "";
                        print(category);
                        Eating = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Eating ? Colors.transparent : Colors.red,
                            width: 2),
                        borderRadius: Eating
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(15),
                        color: Eating
                            ? Colors.red.withOpacity(0.2)
                            : Colors.red.withOpacity(0.2),
                      ),
                      height: 50,
                      width: 100.w,
                      child: Center(
                          child: Text(
                        "🍗 Eating",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 11),
                      ))),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      if (Others == true) {
                        category = "Others";
                        print(category);
                        Others = false;
                      } else {
                        category = "";
                        print(category);
                        Others = true;
                      }
                    });

                    // setState(() {

                    //   jj = true;

                    // });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Others ? Colors.transparent : Colors.black,
                            width: 2),
                        borderRadius: Others
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(15),
                        color: Others
                            ? Colors.black.withOpacity(0.2)
                            : Colors.black.withOpacity(0.2),
                      ),
                      height: 50,
                      width: 110.w,
                      child: Center(
                          child: Text(
                        "Others",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget cc(
    String id,
    String name,
  ) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        color: HexColor("#0c1b32"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(id, style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
