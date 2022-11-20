import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/add.dart';
import 'package:first_app/model/home.dart';
// import 'package:first_app/pages/profile.dart';
// import 'package:first_app/pages/settings.dart';
import 'package:first_app/profile_ui.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class navigation_bar extends StatefulWidget {
  navigation_bar({Key? key}) : super(key: key);

  @override
  State<navigation_bar> createState() => _navigation_barState();
}

class _navigation_barState extends State<navigation_bar> {
  int currentindex = 0;

  TextStyle textStyle = const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      fontStyle: FontStyle.italic);

  List pages = [
    Home(),
    Add(),
    Profile_ui(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(273445),
      body: Center(
        child: pages[currentindex],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle:
                MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            indicatorColor: HexColor("#273445"),
            backgroundColor: Colors.white),
        child: NavigationBar(
            elevation: 0,
            backgroundColor: HexColor("#0c1b32").withOpacity(0.9),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            height: 60,
            selectedIndex: currentindex,
            onDestinationSelected: (int newindex) {
              setState(() {
                currentindex = newindex;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: const Icon(Icons.home),
                label: 'home',
                selectedIcon: Icon(
                  Icons.home_max,
                  color: Colors.white,
                ),
              ),
              const NavigationDestination(
                icon: Icon(Icons.add_box_outlined),
                label: 'add',
                selectedIcon: Icon(
                  Icons.add_box,
                  color: Colors.white,
                ),
              ),
              const NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'profile',
                  selectedIcon: const Icon(
                    Icons.person_outline_outlined,
                    color: Colors.white,
                  )),
            ]),
      ),
    );
  }
}
