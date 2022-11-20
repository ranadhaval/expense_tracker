// import 'dart:html';

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class j extends StatefulWidget {
  // j({Key? key}) : super(key: key);

  // j(this.home);
  // String home;
  @override
  State<j> createState() => _jState();
}

class _jState extends State<j> {
  Map<String, double> datamap = {
    "All": 665,
    'Home Expense': 890,
    "Clothes Shoes": 4456,
    "Cable-Tv": 900,
    "Shopping": 700,
    "Travel": 889,
    "Vehicale": 743,
    "Eating": 698,
    "Others": 565,
  };
  String hy = "";

  late List<String> items;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Analysis"),
          backgroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Text("hii this is chart section"))],
        ));
  }
}
