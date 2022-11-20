
import 'package:flutter/material.dart';

class c_s extends StatefulWidget {
  c_s({Key? key}) : super(key: key);

  @override
  State<c_s> createState() => _SkipState();
}

class _SkipState extends State<c_s> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Contact and Support"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
SizedBox(height: 20,),
            ListTile(title: Text("How it works ? :-",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: "Tra")),),
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
            ListTile(leading: Text("Support :- ",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: "Tra"),)),
            ListTile(
              title: Text(
                  "If any query happening during \nuse Then send your Email in \nfollowing Email Address",style: TextStyle(fontFamily: "Tra")),
            ),
            SizedBox(
              height: 10,
            ),

            Card(
              elevation: 5,
              child: ListTile(title: Center(child: Text("rd755937@gmail.com")),)),
            Card(
              elevation: 5,
              child: ListTile(title: Center(child: Text("rd143761@gmail.com")),)),
           SizedBox(
              height: 10,
            ),
              SizedBox(
              height: 10,
            ),
         
          ],
        ),
      ),
    );
  }
}
