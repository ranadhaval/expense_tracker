import 'dart:developer';

import 'package:flutter/material.dart';

class price extends StatefulWidget {
  price({Key? key}) : super(key: key);

  @override
  State<price> createState() => _priceState();
}

class _priceState extends State<price> {
  int counter = 0;
  int counter2 = 0;
  int price = 0;
  int price2 = 0;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      total = price + price2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [Text("50")],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("price $price"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (counter == 0) {
                        setState(() {
                          counter = 0;
                          price = 0;
                           total = price + price2;
                        });
                      } else {
                        setState(() {
                          counter--;
                          price = price - 50;
                           total = price + price2;
                        });
                      }
                    },
                    child: Card(color: Colors.amber, child: Icon(Icons.remove)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Card(
                      child: Text(
                    "$counter",
                    style: TextStyle(fontSize: 17),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (counter == 0) {
                        setState(() {
                          counter++;
                          price = price + 50;
                           total = price + price2;
                        });
                      } else {
                        setState(() {
                          price = price + 50;
                          counter++;
                           total = price + price2;
                        });
                      }
                    },
                    child: Card(color: Colors.amber, child: Icon(Icons.add)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [Text("150")],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("price $price2"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (counter2 == 0) {
                        setState(() {
                          counter2 = 0;
                           total = price + price2;
                        });
                      } else {
                        setState(() {
                          counter2--;
                          price2 = price2 - 150;
                           total = price + price2;
                        });
                      }
                    },
                    child: Card(color: Colors.amber, child: Icon(Icons.remove)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Card(
                      child: Text(
                    "$counter2",
                    style: TextStyle(fontSize: 17),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (counter2 == 0) {
                        setState(() {
                          counter2++;
                          price2 = price2 + 150;
                          total = price + price2;
                        });
                      } else {
                        setState(() {
                          price2 = price2 + 150;
                          counter2++;
                           total = price + price2;
                        });
                      }
                    },
                    child: Card(color: Colors.amber, child: Icon(Icons.add)),
                  ),
                ],
              ),
            ),
            Card(
              child: Text("Total amount is >> : $total"),
            ),
          ],
        ),
      ),
    ));
  }
}
