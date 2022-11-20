import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("new_users")
          .where("email", isEqualTo: '${firebaseAuth.currentUser!.email}')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('Something went wrong ')));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: Center(
                  child: Text("Loading",
                      style: TextStyle(color: Colors.black, fontSize: 25))));
        }

        return Scaffold(
          backgroundColor: HexColor("#273445"),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Stack(children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          color: HexColor("#62d5c4"),
                          child: Container(
                              // padding: EdgeInsets.all(15),
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width - 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor("#62d5c4"),
                              ),
                              child: Card(
                                elevation: 3,
                                shadowColor: Color.fromARGB(255, 151, 188, 218),
                                color: HexColor("#273445"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                     Container(
                      // padding: EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 250,
                      child: Card(
                        elevation: 10,
                        shadowColor: Color.fromARGB(255, 151, 188, 218),
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: Image(
                            image: NetworkImage(
                              "https://louisville.edu/enrollmentmanagement/images/person-icon/image",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                                    Text(
                                      data['name'],
                                      style:
                                          TextStyle(color: HexColor("#62d5c4"),fontSize: 20),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ]),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
