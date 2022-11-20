//  SingleChildScrollView(
//         child: Container(
//           child: Column(children: [
//             SizedBox(
//               height: 40,
//             ),
//             Center(
//               child: ListTile(
//                 trailing: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://firebasestorage.googleapis.com/v0/b/miniproject-734e0.appspot.com/o/file%2Fimage_picker6030117152656563326.png%2Ffile?alt=media&token=0a6a47cf-f05b-4bb3-926c-71d511f06a27"),
//                 ),
//                 title: Text(
//                   "  New Expense ",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(" Expens title",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Container(
//               // margin: EdgeInsets.all(10),
//               // padding: EdgeInsets.all(8),
//               height: 60,
//               width: MediaQuery.of(context).size.width - 20,
//               // decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(10),
//               //     border: Border.all(color: Colors.grey)),
//               child: TextFormField(
//                 maxLength: 20,
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.grey),
//                   hintText: "Title",
//                   hintStyle: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 17),
//                   contentPadding: EdgeInsets.all(10),
//                   // enabledBorder: OutlineInputBorder(
//                   //     borderRadius: BorderRadius.circular(8),
//                   //     borderSide: BorderSide(color: Colors.grey, width: 1)
//                   //     ),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.green, width: 1)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("   Expens time",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Container(
//               // margin: EdgeInsets.all(10),
//               // padding: EdgeInsets.all(8),
//               height: 60,
//               width: MediaQuery.of(context).size.width - 20,
//               // decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(10),
//               //     border: Border.all(color: Colors.grey)),
//               child: TextFormField(
//                 maxLength: 10,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 17),
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.grey),
//                   labelText: "  Time",
//                   contentPadding: EdgeInsets.all(10),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey, width: 1)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.green, width: 1)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("   Address",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Container(
//               // margin: EdgeInsets.all(10),
//               // padding: EdgeInsets.all(8),
//               height: 60,
//               width: MediaQuery.of(context).size.width - 20,
//               // decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(10),
//               //     border: Border.all(color: Colors.grey)),
//               child: TextFormField(
//                 // maxLength: 10,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 17),
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.grey),
//                   labelText: "  Address",
//                   contentPadding: EdgeInsets.all(10),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey, width: 1)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.green, width: 1)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("   Expens value",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Container(
//               // margin: EdgeInsets.all(10),
//               // padding: EdgeInsets.all(8),
//               height: 60,
//               width: MediaQuery.of(context).size.width - 20,
//               // decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(10),
//               //     border: Border.all(color: Colors.grey)),
//               child: TextFormField(
//                 maxLength: 10,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 17),
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.grey),
//                   labelText: "  Expense value",
//                   contentPadding: EdgeInsets.all(10),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.grey, width: 1)),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide(color: Colors.green, width: 1)),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("   Category",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 5,
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (All == true) {
//                                 category = "All";
//                                 print(category);
//                                 All = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 All = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: All
//                                           ? Colors.transparent
//                                           : Colors.black.withOpacity(0.1),
//                                       width: 2),
//                                   borderRadius: All
//                                       ? BorderRadius.circular(10)
//                                       : BorderRadius.circular(15),
//                                   color: All
//                                       ? Colors.blue.withOpacity(0.2)
//                                       : Colors.blue.withOpacity(0.2),
//                                 ),
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width - 300,
//                                 child: Center(
//                                     child: Text(
//                                   "All",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ))),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (Home_eX == true) {
//                                 category = "Home Expense";
//                                 print(category);
//                                 Home_eX = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 Home_eX = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Home_eX
//                                         ? Colors.transparent
//                                         : Colors.teal,
//                                     width: 2),
//                                 borderRadius: Home_eX
//                                     ? BorderRadius.circular(10)
//                                     : BorderRadius.circular(15),
//                                 color: Home_eX
//                                     ? Colors.teal.withOpacity(0.2)
//                                     : Colors.teal.withOpacity(0.2),
//                               ),
//                               height: 50,
//                               width: MediaQuery.of(context).size.width - 230,
//                               child: Center(
//                                   child: Text(
//                                 "⛪ Home Expense ",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 11),
//                               ))),
//                         ),
//                         SizedBox(
//                           width: 7,
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (Clothes == true) {
//                                 category = "Clothes - Shoes";
//                                 print(category);
//                                 Clothes = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 Clothes = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Clothes
//                                         ? Colors.transparent
//                                         : Colors.pink,
//                                     width: 2),
//                                 borderRadius: Clothes
//                                     ? BorderRadius.circular(10)
//                                     : BorderRadius.circular(15),
//                                 color: Clothes
//                                     ? Colors.pink.withOpacity(0.2)
//                                     : Colors.pink.withOpacity(0.2),
//                               ),
//                               height: 50,
//                               width: MediaQuery.of(context).size.width - 230,
//                               child: Center(
//                                   child: Text(
//                                 "🥼👞 Clothes - Shoes",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 11),
//                               ))),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (cable == true) {
//                                 category = "Cable-Tv";
//                                 print(category);
//                                 cable = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 cable = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: cable
//                                           ? Colors.transparent
//                                           : Colors.grey,
//                                       width: 2),
//                                   borderRadius: cable
//                                       ? BorderRadius.circular(10)
//                                       : BorderRadius.circular(15),
//                                   color: cable
//                                       ? Colors.grey.withOpacity(0.2)
//                                       : Colors.grey.withOpacity(0.2),
//                                 ),
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width - 250,
//                                 child: Center(
//                                     child: Text(
//                                   "🔌📺  Cable-Tv",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 11),
//                                 ))),
//                           ),
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (shopping == true) {
//                                 category = "Shopping";
//                                 print(category);
//                                 shopping = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 shopping = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(3.0),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: shopping
//                                           ? Colors.transparent
//                                           : Colors.amber,
//                                       width: 2),
//                                   borderRadius: shopping
//                                       ? BorderRadius.circular(10)
//                                       : BorderRadius.circular(15),
//                                   color: shopping
//                                       ? Colors.amber.withOpacity(0.2)
//                                       : Colors.amber.withOpacity(0.2),
//                                 ),
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width - 280,
//                                 child: Center(
//                                     child: Text(
//                                   "🛒 Shopping",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 11),
//                                 ))),
//                           ),
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (travel == true) {
//                                 category = "travel";
//                                 print(category);
//                                 travel = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 travel = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(3.0),
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: travel
//                                           ? Colors.transparent
//                                           : Colors.green,
//                                       width: 2),
//                                   borderRadius: travel
//                                       ? BorderRadius.circular(10)
//                                       : BorderRadius.circular(15),
//                                   color: travel
//                                       ? Colors.green.withOpacity(0.2)
//                                       : Colors.green.withOpacity(0.2),
//                                 ),
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width - 280,
//                                 child: Center(
//                                     child: Text(
//                                   "🚆✈ travel",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 11),
//                                 ))),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (vehicle == true) {
//                                 category = "Vehicle";
//                                 print(category);
//                                 vehicle = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 vehicle = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: vehicle
//                                         ? Colors.transparent
//                                         : Colors.blue,
//                                     width: 2),
//                                 borderRadius: vehicle
//                                     ? BorderRadius.circular(10)
//                                     : BorderRadius.circular(15),
//                                 color: vehicle
//                                     ? Colors.blue.withOpacity(0.2)
//                                     : Colors.blue.withOpacity(0.2),
//                               ),
//                               height: 50,
//                               width: MediaQuery.of(context).size.width - 280,
//                               child: Center(
//                                   child: Text(
//                                 "🛺🚗 Vehicle",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 11),
//                               ))),
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (Eating == true) {
//                                 category = "Eating";
//                                 print(category);
//                                 Eating = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 Eating = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Eating
//                                         ? Colors.transparent
//                                         : Colors.red,
//                                     width: 2),
//                                 borderRadius: Eating
//                                     ? BorderRadius.circular(10)
//                                     : BorderRadius.circular(15),
//                                 color: Eating
//                                     ? Colors.red.withOpacity(0.2)
//                                     : Colors.red.withOpacity(0.2),
//                               ),
//                               height: 50,
//                               width: MediaQuery.of(context).size.width - 280,
//                               child: Center(
//                                   child: Text(
//                                 "🍗 Eating",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 11),
//                               ))),
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         InkWell(
//                           borderRadius: BorderRadius.circular(15),
//                           onTap: () {
//                             setState(() {
//                               if (Others == true) {
//                                 category = "Others";
//                                 print(category);
//                                 Others = false;
//                               } else {
//                                 category = "";
//                                 print(category);
//                                 Others = true;
//                               }
//                             });

//                             // setState(() {

//                             //   jj = true;

//                             // });
//                           },
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Others
//                                         ? Colors.transparent
//                                         : Colors.black,
//                                     width: 2),
//                                 borderRadius: Others
//                                     ? BorderRadius.circular(10)
//                                     : BorderRadius.circular(15),
//                                 color: Others
//                                     ? Colors.black.withOpacity(0.2)
//                                     : Colors.black.withOpacity(0.2),
//                               ),
//                               height: 50,
//                               width: MediaQuery.of(context).size.width - 280,
//                               child: Center(
//                                   child: Text(
//                                 "Others",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ))),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("   Payment method",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       ))
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 5,
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(15),
//                     onTap: () {
//                       setState(() {
//                         if (online == true) {
//                           payment_method = "online";
//                           print(payment_method);
//                           online = false;
//                         } else {
//                           payment_method = "";
//                           print(payment_method);
//                           online = true;
//                         }
//                       });

//                       // setState(() {

//                       //   jj = true;

//                       // });
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: online
//                                     ? Colors.transparent
//                                     : Colors.black.withOpacity(0.1),
//                                 width: 2),
//                             borderRadius: online
//                                 ? BorderRadius.circular(10)
//                                 : BorderRadius.circular(15),
//                             color: online
//                                 ? Colors.blue.withOpacity(0.2)
//                                 : Colors.blue.withOpacity(0.2),
//                           ),
//                           height: 50,
//                           width: MediaQuery.of(context).size.width - 260,
//                           child: Center(
//                               child: Text(
//                             "📱 Online",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 11),
//                           ))),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(15),
//                     onTap: () {
//                       setState(() {
//                         if (offline == true) {
//                           payment_method = "offline";
//                           print(payment_method);
//                           offline = false;
//                         } else {
//                           payment_method = "";
//                           print(payment_method);
//                           offline = true;
//                         }
//                       });

//                       // setState(() {

//                       //   jj = true;

//                       // });
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: offline ? Colors.transparent : Colors.teal,
//                               width: 2),
//                           borderRadius: offline
//                               ? BorderRadius.circular(10)
//                               : BorderRadius.circular(15),
//                           color: offline
//                               ? Colors.teal.withOpacity(0.2)
//                               : Colors.teal.withOpacity(0.2),
//                         ),
//                         height: 50,
//                         width: MediaQuery.of(context).size.width - 250,
//                         child: Center(
//                             child: Text(
//                           "📴 Ofline ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 11),
//                         ))),
//                   ),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(15),
//                     onTap: () {
//                       setState(() {
//                         if (pending == true) {
//                           payment_method = "pending";
//                           print(category);
//                           pending = false;
//                         } else {
//                           payment_method = "";
//                           print(payment_method);
//                           pending = true;
//                         }
//                       });

//                       // setState(() {

//                       //   jj = true;

//                       // });
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: pending ? Colors.transparent : Colors.pink,
//                               width: 2),
//                           borderRadius: pending
//                               ? BorderRadius.circular(10)
//                               : BorderRadius.circular(15),
//                           color: pending
//                               ? Colors.pink.withOpacity(0.2)
//                               : Colors.pink.withOpacity(0.2),
//                         ),
//                         height: 50,
//                         width: MediaQuery.of(context).size.width - 250,
//                         child: Center(
//                             child: Text(
//                           "📑 Pending",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 11),
//                         ))),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(3.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text("   Choose doc",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                       )),
//                 ],
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 7,
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(15),
//                     onTap: () {
//                       setState(() {
//                         if (pen == true) {
                         
//                           pen = false;
//                         } else {
                      
//                           pen = true;
//                         }
//                       });

//                       // setState(() {

//                       //   jj = true;

//                       // });
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: pen ? Colors.transparent : Colors.blue,
//                               width: 2),
//                           borderRadius: pen
//                               ? BorderRadius.circular(10)
//                               : BorderRadius.circular(15),
//                           color: pending
//                               ? Colors.blue.withOpacity(0.2)
//                               : Colors.blue.withOpacity(0.2),
//                         ),
//                         height: 50,
//                         width: MediaQuery.of(context).size.width - 250,
//                         child: Center(
//                             child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.blue) ),
//                                 child: Icon(Icons.add,color: Colors.blue,)),
//                                 SizedBox(width: 4,),
//                             Text(
//                               "📂",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 30),
//                             ),
//                           ],
//                         ))),
//                   ),
//                 ],
//               ),
//             ),
//  SizedBox(
//                     width: 27,
//                   ),


//   Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 17,
//                   ),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(15),
//                     onTap: () {
//                       setState(() {
//                         if (pen == true) {
                         
//                           pen = false;
//                         } else {
                      
//                           pen = true;
//                         }
//                       });

//                       // setState(() {

//                       //   jj = true;

//                       // });
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: pen ? Colors.transparent : Colors.blue,
//                               width: 2),
//                           borderRadius: 
//                                BorderRadius.circular(15),
//                           color:  Colors.blue.withOpacity(0.5)
                               
//                         ),
//                         height: 50,
//                         width: MediaQuery.of(context).size.width - 70,
//                         child: Center(
//                             child: Text(
//                               "Add Expense",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 30),
//                             ))),
//                   ),
//                 ],
//               ),
//             )


//           ]),
//         ),
//       ),
  