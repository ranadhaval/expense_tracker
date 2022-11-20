

import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/model/home.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController Title_controller = TextEditingController();
  TextEditingController Expense_time_controller = TextEditingController();
  TextEditingController ex_value = TextEditingController();
  TextEditingController Address_controoleer = TextEditingController();

  Future<Future<DocumentReference<Map<String, dynamic>>>> add(
      String id, String urlx) async {
    var reference2 = FirebaseFirestore.instance
        .collection('new_users')
        .doc(id)
        .collection("address");

    return reference2.add({
      'id': reference2.id,
      'Title': "${Title_controller.text}",
      "Time": "${Expense_time_controller.text}",
      "category": "$category",
      "payment_method": "$payment_method",
      "value": " ₹ ${ex_value.text}",
      "Address": "${Address_controoleer.text}",
      "doc": urlx,
      "icon": icone,
      "payment_icon ": payment_icon,
    });
  }

  final key = GlobalKey<FormState>();

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

  String category = "";
  String payment_method = "";
  String icone = "";
  String payment_icon = "";

  // var icon = Icons.add;
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  var now = DateTime.now();

  // dynamic currenttime = DateFormat.jm().format(DateTime.now());
// for location
  String Adress = "null";

  Future<void> get_current_location() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    String add =
        "${place.subLocality},${place.subAdministrativeArea},${place.administrativeArea}";

    setState(() {
      Address_controoleer.text = add;
    });
  }

  get_current_time() {
    String real_time_with_date =
        "${currentTime}  ${now.day} / ${now.month} / ${now.year}";
    setState(() {
      Expense_time_controller.text = real_time_with_date;
    });
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// for uploading image in doc

  File? imagex;

// 1 step
  bool dg = true;
  Future image_from_camera() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image == null) return;

    setState(() {
      if (image != null) {
        imagex = File(image.path);
        setState(() {
          dg = false;
        });
      } else {
        print("no image selected yet!");
      }
    });
  }

// 1 step
  Future image_from_galery(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final temp_image = File(image.path);
      setState(() {
        imagex = temp_image;
        Navigator.pop(context);
        dg = false;
      });

      print(image);
    } catch (e) {
      print(e);
    }
  }

  final userrefd = FirebaseFirestore.instance.collection("new_users").doc();
  final storegref = FirebaseStorage.instance;

// 2 step

  Future upload_image() async {
    if (imagex == null) return;
    final fileName = basename(imagex!.path);
    final destination = 'file/$fileName';

    UploadTask uploadTask =
        storegref.ref(destination).child("/file").putFile(imagex!);
    final storegsnap = await uploadTask.whenComplete(() {});
    final downloadurl = await storegsnap.ref.getDownloadURL();
    return downloadurl;
  }

// 3 step

// 4 step

  submit(
    String id,
  ) async {
    String mediaurl = await upload_image();
    print(mediaurl);
    add(id, mediaurl);

    setState(() {
      imagex == null;
    });
  }

  select_image(ParentContext) {
    return showDialog(
        context: ParentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose option"),
            children: [
              SimpleDialogOption(
                child: Text("Pick image via Camera"),
                onPressed: image_from_camera,
              ),
              SimpleDialogOption(
                child: Text("Pick image via Galllery"),
                onPressed: () {
                  image_from_galery(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          
          builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {

            ScreenUtil.init(context,);
            if (snapshot.hasError) {
              return MaterialApp(
                home: Scaffold(
                    body: Center(
                  child: Text("no data found yet !"),
                )),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            var icon = Icon(Icons.logout);
            return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 0,
                  elevation: 0,
                  backgroundColor: HexColor("#0c1b32"),

                ),
                body:
                 StreamBuilder(


                  stream: FirebaseFirestore.instance
                      .collection("new_users")
                      .where("email",
                          isEqualTo: '${firebaseAuth.currentUser!.email}')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                          body: Center(child: Text('Something went wrong ')));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Scaffold(
                          body: Center(
                              child: Text("Loading...",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25))));
                    }

                    return Scaffold(
                      backgroundColor: HexColor("#0c1b32"),
                      appBar: AppBar(
                          toolbarHeight: 0,
                          elevation: 0,
                          backgroundColor: Colors.white),
                      body: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          return SingleChildScrollView(
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.white,
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: snapshot.data!.docs.map(
                                          (DocumentSnapshot documentSnapshot) {
                                        Map data = documentSnapshot.data()
                                            as Map<String, dynamic>;

                                        data['id'] = documentSnapshot.id;

                                        return
                                        
                                         StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('new_users')
                                                .doc(data['id'])
                                                .collection('address')
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    orderSnapshot) {
                                              return orderSnapshot.hasData
                                                  ? Form(
                                                      key: key,
                                                      child: Container(
                                                        child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 40,
                                                              ),
                                                              Center(
                                                                child: ListTile(
                                                                  trailing:
                                                                      CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            data['image']),
                                                                  ),
                                                                  title: Text(
                                                                    "  New Expense ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            30),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        " Expens title",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                // margin: EdgeInsets.all(10),
                                                                // padding: EdgeInsets.all(8),
                                                                height: 60,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    20,
                                                                // decoration: BoxDecoration(
                                                                //     borderRadius: BorderRadius.circular(10),
                                                                //     border: Border.all(color: Colors.grey)),
                                                                child:
                                                                    TextFormField(
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      wordSpacing:
                                                                          2,
                                                                      letterSpacing:
                                                                          1,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17),
                                                                  controller:
                                                                      Title_controller,
                                                                  validator: (val) => val !=
                                                                              null &&
                                                                          val.isEmpty
                                                                      ? "empty Title "
                                                                      : null,
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  maxLength: 15,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelStyle:
                                                                        TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                    hintText:
                                                                        "Title",
                                                                    hintStyle: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            17),
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    // enabledBorder: OutlineInputBorder(
                                                                    //     borderRadius: BorderRadius.circular(8),
                                                                    //     borderSide: BorderSide(color: Colors.grey, width: 1)
                                                                    //     ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.green,
                                                                            width: 1)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "   Expens time",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        )),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        get_current_time();
                                                                      },
                                                                      child:
                                                                          Card(
                                                                        child: Text(
                                                                            "   Get Current Time",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blueGrey,
                                                                              fontWeight: FontWeight.bold,
                                                                            )),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Container(
                                                                // margin: EdgeInsets.all(10),
                                                                // padding: EdgeInsets.all(8),
                                                                height: 60,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    20,
                                                                // decoration: BoxDecoration(
                                                                //     borderRadius: BorderRadius.circular(10),
                                                                //     border: Border.all(color: Colors.grey)),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      Expense_time_controller,
                                                                  validator: (val) => val !=
                                                                              null &&
                                                                          val.isEmpty
                                                                      ? "time value is null"
                                                                      : null,
                                                                  maxLength: 23,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelStyle:
                                                                        TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                    hintText:
                                                                        "  Time",
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.green,
                                                                            width: 1)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "   Address",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        )),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          bool
                                                                              ServiceEnable;
                                                                          LocationPermission
                                                                              permission;

                                                                          ServiceEnable =
                                                                              await Geolocator.isLocationServiceEnabled();

                                                                          if (!ServiceEnable) {
                                                                            await Geolocator.openLocationSettings();
                                                                            return Future.error("Location  are emabled");
                                                                          }
                                                                          permission =
                                                                              await Geolocator.checkPermission();

                                                                          if (permission ==
                                                                              LocationPermission.denied) {
                                                                            permission =
                                                                                await Geolocator.requestPermission();
                                                                            if (permission ==
                                                                                LocationPermission.denied) {
                                                                              return Future.error("location permission denied");
                                                                            }
                                                                          }

                                                                          if (permission ==
                                                                              LocationPermission.deniedForever) {
                                                                            return Future.error("request permission denied forever we cannot access location ");
                                                                          } else {
                                                                            get_current_location();
                                                                          }

                                                                          // get_real_location(position);
                                                                        },
                                                                        child:
                                                                            Card(
                                                                          elevation:
                                                                              5,
                                                                          child:
                                                                              Text(
                                                                            "(Get Current Location)",
                                                                            style:
                                                                                TextStyle(color: Colors.amber, fontSize: 15),
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Container(
                                                                // margin: EdgeInsets.all(10),
                                                                // padding: EdgeInsets.all(8),
                                                                height: 60,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    20,
                                                                // decoration: BoxDecoration(
                                                                //     borderRadius: BorderRadius.circular(10),
                                                                //     border: Border.all(color: Colors.grey)),
                                                                child:
                                                                    TextFormField(
                                                                  maxLength: 40,
                                                                  controller:
                                                                      Address_controoleer,
                                                                  validator: (val) => val !=
                                                                              null &&
                                                                          val.isEmpty
                                                                      ? "valu is null"
                                                                      : null,
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  // maxLength: 10,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelStyle:
                                                                        TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                    hintText:
                                                                        "  Address",
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.green,
                                                                            width: 1)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "   Expens value",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Container(
                                                                // margin: EdgeInsets.all(10),
                                                                // padding: EdgeInsets.all(8),
                                                                height: 60,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width -
                                                                    20,
                                                                // decoration: BoxDecoration(
                                                                //     borderRadius: BorderRadius.circular(10),
                                                                //     border: Border.all(color: Colors.grey)),
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      ex_value,
                                                                  validator: (val) => val !=
                                                                              null &&
                                                                          val.isEmpty
                                                                      ? "valu is null"
                                                                      : null,
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  maxLength: 6,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          17),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    prefix: Text(
                                                                        "₹ "),
                                                                    labelStyle:
                                                                        TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                    hintText:
                                                                        "  Expense value",
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Colors.green,
                                                                            width: 1)),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "   Category",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Container(
                                                                       height: 165.h,
        width: 440.w,
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (All == true) {
                                                                                  category = "All";
                                                                                  print(category);
                                                                                  All = false;
                                                                                  icone = "❄🔳";
                                                                                } else {
                                                                                  category = "";
                                                                                  icone = "";
                                                                                  print(category);
                                                                                  All = true;
                                                                                }
                                                                              });

                                                                              // setState(() {

                                                                              //   jj = true;

                                                                              // });
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(2.0),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(color: All ? Colors.transparent : Colors.black.withOpacity(0.1), width: 2),
                                                                                    borderRadius: All ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                    color: All ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
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
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (Home_eX == true) {
                                                                                  category = "Home Expense";
                                                                                  icone = "⛪";
                                                                                  print(category);
                                                                                  Home_eX = false;
                                                                                } else {
                                                                                  category = "";
                                                                                  icone = "";
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
                                                                                  border: Border.all(color: Home_eX ? Colors.transparent : Colors.teal, width: 2),
                                                                                  borderRadius: Home_eX ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                  color: Home_eX ? Colors.teal.withOpacity(0.2) : Colors.teal.withOpacity(0.2),
                                                                                ),
                                                                                height: 50,
                                                                                width: 100.w,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "⛪ Home Expense ",
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                                ))),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                7,
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (Clothes == true) {
                                                                                  category = "Clothes - Shoes";
                                                                                  print(category);
                                                                                  icone = "🥼";
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
                                                                                  border: Border.all(color: Clothes ? Colors.transparent : Colors.pink, width: 2),
                                                                                  borderRadius: Clothes ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                  color: Clothes ? Colors.pink.withOpacity(0.2) : Colors.pink.withOpacity(0.2),
                                                                                ),
                                                                                height: 50,
                                                                                width: 105.w,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "🥼👞 Clothes - Shoes",
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                                                                ))),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (cable == true) {
                                                                                  category = "Cable-Tv";
                                                                                  icone = "📺🔌";
                                                                                  print(category);
                                                                                  cable = false;
                                                                                } else {
                                                                                  category = "";
                                                                                  icone = "";
                                                                                  print(category);
                                                                                  cable = true;
                                                                                }
                                                                              });

                                                                              // setState(() {

                                                                              //   jj = true;

                                                                              // });
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(color: cable ? Colors.transparent : Colors.grey, width: 2),
                                                                                    borderRadius: cable ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                    color: cable ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                                                                                  ),
                                                                                  height: 50,
                                                                                  width: 90.w,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "🔌📺  Cable-Tv",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                                  ))),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (shopping == true) {
                                                                                  icone = "🛒";
                                                                                  category = "Shopping";
                                                                                  print(category);
                                                                                  shopping = false;
                                                                                } else {
                                                                                  icone = "";
                                                                                  category = "";
                                                                                  print(category);
                                                                                  shopping = true;
                                                                                }
                                                                              });

                                                                              // setState(() {

                                                                              //   jj = true;

                                                                              // });
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(3.0),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(color: shopping ? Colors.transparent : Colors.amber, width: 2),
                                                                                    borderRadius: shopping ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                    color: shopping ? Colors.amber.withOpacity(0.2) : Colors.amber.withOpacity(0.2),
                                                                                  ),
                                                                                  height: 50,
                                                                                  width: 90.w,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "🛒 Shopping",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                                  ))),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (travel == true) {
                                                                                  icone = "✈";
                                                                                  category = "travel";
                                                                                  print(category);
                                                                                  travel = false;
                                                                                } else {
                                                                                  icone = "";
                                                                                  category = "";
                                                                                  print(category);
                                                                                  travel = true;
                                                                                }
                                                                              });

                                                                              // setState(() {

                                                                              //   jj = true;

                                                                              // });
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(3.0),
                                                                              child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(color: travel ? Colors.transparent : Colors.green, width: 2),
                                                                                    borderRadius: travel ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                    color: travel ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                                                                                  ),
                                                                                  height: 50,
                                                                                  width: 90.w,
                                                                                  child: Center(
                                                                                      child: Text(
                                                                                    "🚆✈ travel",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                                  ))),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (vehicle == true) {
                                                                                  icone = "🛺";
                                                                                  category = "Vehicle";
                                                                                  print(category);
                                                                                  vehicle = false;
                                                                                } else {
                                                                                  icone = "";
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
                                                                                  border: Border.all(color: vehicle ? Colors.transparent : Colors.blue, width: 2),
                                                                                  borderRadius: vehicle ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                  color: vehicle ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                                                                                ),
                                                                                height: 50,
                                                                                width: 80.w,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "🛺🚗 Vehicle",
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                                ))),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (Eating == true) {
                                                                                  icone = "🍗";
                                                                                  category = "Eating";
                                                                                  print(category);
                                                                                  Eating = false;
                                                                                } else {
                                                                                  icone = "";
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
                                                                                  border: Border.all(color: Eating ? Colors.transparent : Colors.red, width: 2),
                                                                                  borderRadius: Eating ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                  color: Eating ? Colors.red.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                                                                                ),
                                                                                height: 50,
                                                                                width: 80.w,
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  "🍗 Eating",
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                                ))),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                8,
                                                                          ),
                                                                          InkWell(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                if (Others == true) {
                                                                                  icone = "🤔";
                                                                                  category = "Others";
                                                                                  print(category);
                                                                                  Others = false;
                                                                                } else {
                                                                                  icone = "";
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
                                                                                  border: Border.all(color: Others ? Colors.transparent : Colors.black, width: 2),
                                                                                  borderRadius: Others ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                                  color: Others ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.2),
                                                                                ),
                                                                                height: 50,
                                                                                width: 80.w,
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
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "   Payment method",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    InkWell(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (online ==
                                                                              true) {
                                                                            payment_icon =
                                                                                "📱";
                                                                            payment_method =
                                                                                "online";
                                                                            print(payment_method);
                                                                            online =
                                                                                false;
                                                                          } else {
                                                                            payment_icon =
                                                                                "";
                                                                            payment_method =
                                                                                "";
                                                                            print(payment_method);
                                                                            online =
                                                                                true;
                                                                          }
                                                                        });

                                                                        // setState(() {

                                                                        //   jj = true;

                                                                        // });
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(2.0),
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(color: online ? Colors.transparent : Colors.black.withOpacity(0.1), width: 2),
                                                                              borderRadius: online ? BorderRadius.circular(10) : BorderRadius.circular(15),
                                                                              color: online ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                                                                            ),
                                                                            height: 50,
                                                                            width: 100.w,
                                                                            child: Center(
                                                                                child: Text(
                                                                              "📱 Online",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                            ))),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    InkWell(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (offline ==
                                                                              true) {
                                                                            payment_icon =
                                                                                "📴";
                                                                            payment_method =
                                                                                "offline";
                                                                            print(payment_method);
                                                                            offline =
                                                                                false;
                                                                          } else {
                                                                            payment_icon =
                                                                                "";
                                                                            payment_method =
                                                                                "";
                                                                            print(payment_method);
                                                                            offline =
                                                                                true;
                                                                          }
                                                                        });

                                                                        // setState(() {

                                                                        //   jj = true;

                                                                        // });
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: offline ? Colors.transparent : Colors.teal, width: 2),
                                                                            borderRadius: offline
                                                                                ? BorderRadius.circular(10)
                                                                                : BorderRadius.circular(15),
                                                                            color: offline
                                                                                ? Colors.teal.withOpacity(0.2)
                                                                                : Colors.teal.withOpacity(0.2),
                                                                          ),
                                                                          height: 50,
                                                                          width: 100.w,
                                                                          child: Center(
                                                                              child: Text(
                                                                            "📴 Ofline ",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                                                                          ))),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 7,
                                                                    ),
                                                                    InkWell(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          if (pending ==
                                                                              true) {
                                                                            payment_icon =
                                                                                "📑";
                                                                            payment_method =
                                                                                "pending";
                                                                            print(category);
                                                                            pending =
                                                                                false;
                                                                          } else {
                                                                            payment_icon =
                                                                                "";
                                                                            payment_method =
                                                                                "";
                                                                            print(payment_method);
                                                                            pending =
                                                                                true;
                                                                          }
                                                                        });

                                                                        // setState(() {

                                                                        //   jj = true;

                                                                        // });
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: pending ? Colors.transparent : Colors.pink, width: 2),
                                                                            borderRadius: pending
                                                                                ? BorderRadius.circular(10)
                                                                                : BorderRadius.circular(15),
                                                                            color: pending
                                                                                ? Colors.pink.withOpacity(0.2)
                                                                                : Colors.pink.withOpacity(0.2),
                                                                          ),
                                                                          height: 50,
                                                                          width: 100.w,
                                                                          child: Center(
                                                                              child: Text(
                                                                            "📑 Pending",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                                                          ))),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        3.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        "   Choose doc",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 7,
                                                                    ),
                                                                    InkWell(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      onTap:
                                                                          () {
                                                                        select_image(
                                                                            context);
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(10), color: Colors.white),
                                                                          height: 70,
                                                                          width: MediaQuery.of(context).size.width - 220,
                                                                          child: Center(
                                                                              child: Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                      child: Icon(
                                                                                        Icons.photo,
                                                                                        color: Colors.black.withOpacity(0.4),
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 14,
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  select_image(context);
                                                                                },
                                                                                child: Center(
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        "Drop image",
                                                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ))),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 27,
                                                              ),
                                                              dg
                                                                  ? Container(
                                                                      height: 0,
                                                                      width: 0,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.5),
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          border:
                                                                              Border.all(color: Colors.black)),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          300,
                                                                      width:
                                                                          300,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.grey.withOpacity(
                                                                              0.5),
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          border:
                                                                              Border.all(color: Colors.black)),
                                                                      child: Image
                                                                          .file(
                                                                        imagex!,
                                                                        height:
                                                                            300,
                                                                        width:
                                                                            300,
                                                                      ),
                                                                    ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: 17,
                                                                    ),
                                                                    InkWell(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      onTap:
                                                                          () async {
                                                                        try {
                                                                          final form_key = key
                                                                              .currentState!
                                                                              .validate();

                                                                          if (form_key) {
                                                                            submit(data['id']);
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                              content: Text("data Processing................"),
                                                                              backgroundColor: Colors.green,
                                                                            ));

                                                                            // setState(() {
                                                                            //   Title_controller.text = "";
                                                                            //   ex_value.text = "";
                                                                            //   Address_controoleer.text = "";
                                                                            //   Expense_time_controller.text = "";

                                                                            //   All = true;
                                                                            //   Home_eX = true;
                                                                            //   Clothes = true;
                                                                            //   cable = true;
                                                                            //   shopping = true;
                                                                            //   travel = true;
                                                                            //   vehicle = true;
                                                                            //   Eating = true;
                                                                            //   Others = true;
                                                                            //   offline = true;
                                                                            //   online = true;
                                                                            //   pending = true;
                                                                            //   pen = true;
                                                                            // });
                                                                            Navigator.push(context,
                                                                                MaterialPageRoute(builder: (builder) => Home()));
                                                                          } else {
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                              content: Text("fORM IS NOT VALI DATE"),
                                                                              backgroundColor: Colors.red,
                                                                            ));
                                                                          }
                                                                        } catch (e) {
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            content:
                                                                                Text("$e"),
                                                                            backgroundColor:
                                                                                Colors.red,
                                                                          ));
                                                                        }
                                                                      },
                                                                      child: Container(
                                                                          decoration: BoxDecoration(border: Border.all(color: pen ? Colors.transparent : Colors.blue, width: 2), borderRadius: BorderRadius.circular(15), color: Colors.blue.withOpacity(0.5)),
                                                                          height: 50,
                                                                          width: MediaQuery.of(context).size.width - 70,
                                                                          child: Center(
                                                                              child: Text(
                                                                            "Add Expense",
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                                                          ))),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 100,
                                                              ),
                                                            ]),
                                                      ),
                                                    )
                                                  : Text(" ");
                                            });
                                      }).toList(),
                                    ),
                                  )));
                        }).toList(),
                      ),
                    );
                  },
                ));
          }),
          stream: FirebaseFirestore.instance
              .collection("new_users")
              .where("email", isEqualTo: '${firebaseAuth.currentUser!.email}')
              .snapshots(),
        ));
  }

  bool jj = true;
}
