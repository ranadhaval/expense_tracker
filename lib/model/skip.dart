// import 'package:first_app/pages/signup_and_signin.dart';
import 'package:first_app/model/signup_and_signin.dart';
import 'package:flutter/material.dart';

class Skip extends StatefulWidget {
  Skip({Key? key}) : super(key: key);

  @override
  State<Skip> createState() => _SkipState();
}

class _SkipState extends State<Skip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("Expense Tracker"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.white,
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width - 10,
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            height: MediaQuery.of(context).size.height / 1.8,
                            width: MediaQuery.of(context).size.width - 10,
                            child: FittedBox(
                              child: Image(
                                image: AssetImage("Assets/1.jpeg"),
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "Making list of Expense With Categories",
                          style: TextStyle(
                              fontFamily: "Tra", fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            height: MediaQuery.of(context).size.height / 1.8,
                            width: MediaQuery.of(context).size.width - 10,
                            child: FittedBox(
                              child: Image(
                                image: AssetImage("Assets/2.jpeg"),
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "View of pending offline and online payments",
                          style: TextStyle(
                            fontFamily: "Tra",
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            height: MediaQuery.of(context).size.height / 1.8,
                            width: MediaQuery.of(context).size.width - 10,
                            child: FittedBox(
                              child: Image(
                                image: AssetImage("Assets/3.jpeg"),
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "Add your  expense with categories and reciept",
                          style: TextStyle(
                              fontFamily: "Tra", fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            height: MediaQuery.of(context).size.height / 1.8,
                            width: MediaQuery.of(context).size.width - 10,
                            child: FittedBox(
                              child: Image(
                                image: AssetImage("Assets/4.jpeg"),
                                fit: BoxFit.fill,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "View recently added expense in profile section",
                          style: TextStyle(
                              fontFamily: "Tra", fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => Sign_up()),
                    (route) => false);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: Center(
                  child: Text(
                    "let's gets started",
                    style: TextStyle(color: Colors.white,fontFamily: "Tra",fontSize: 18),
                    
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
