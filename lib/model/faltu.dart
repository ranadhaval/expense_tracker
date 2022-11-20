// // import 'dart:html';

// // import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:pie_chart/pie_chart.dart';

// class j extends StatefulWidget {
//   // j({Key? key}) : super(key: key);

//   j(this.home);
//   String home;
//   @override
//   State<j> createState() => _jState();
// }

// class _jState extends State<j> {
//   Map<String, double> datamap = {
//     "All": 665,
//     'Home Expense': 890,
//     "Clothes Shoes": 4456,
//     "Cable-Tv": 900,
//     "Shopping": 700,
//     "Travel": 889,
//     "Vehicale": 743,
//     "Eating": 698,
//     "Others": 565,
//   };
//   String hy = "";

//   late List<String> items;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Data Analysis"),
//           backgroundColor: Colors.black,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             StreamBuilder(
//                 stream: FirebaseFirestore.instance.collection("dd").snapshots(),
//                 builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasError) {
//                     return CircularProgressIndicator();
//                   }

//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   }

//                   return snapshot.hasData
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: snapshot.data!.docs
//                               .map((DocumentSnapshot snapshot22) {
//                             Map<String, dynamic> dataok =
//                                 snapshot22.data() as Map<String, dynamic>;
//                             // DocumentReference<String> ff;
//                             hy = "${dataok['hh']}";

//                             print(int.tryParse(hy, radix: 3));
//                             dataok['id'] = snapshot22.data();
//                             int sum = 0;
//                             for (int i = 0; i < dataok.length; i++) {
//                               int x = int.tryParse(dataok['hh'], radix: 2);
//                               print(x);
//                             }

//                             return Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 InkWell(
//                                   onTap: () {},
//                                   child: Center(
//                                     child: Text(
//                                       "${dataok['hh']}",
//                                       style: TextStyle(color: Colors.amber),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }).toList())
//                       : CircularProgressIndicator();
//                 }))
//           ],
//         ));
//   }
// }
