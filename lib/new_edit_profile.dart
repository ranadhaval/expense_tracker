import 'dart:math';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/model/forget.dart';
// import 'package:first_app/pages/forget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class Edits extends StatefulWidget {
  String name, email, image, position, id, pass, join;
  Edits(
      {required this.join,
      required this.id,
      required this.pass,
      required this.email,
      required this.image,
      required this.name,
      required this.position});
  // Edit({Key? key}) : super(key: key);

  @override
  State<Edits> createState() => _EditState();
}

class _EditState extends State<Edits> {
  final key = GlobalKey<FormState>();

  final userref = FirebaseFirestore.instance.collection("new_users");
  final formkey = GlobalKey<FormState>();

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
    } on PlatformException catch (e) {
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
  update_image(String url) async {
    userref.doc("${widget.id}").update({"image": url});
  }

// 4 step

  update_file() {
    userref.doc("${widget.id}").update({
      "name": "${name_controller.text}",
      "about": "${about_controller.text} ",
      "position": "${pass_controller.text}",
    });
  }

  submit() async {
    String mediaurl = await upload_image();
    print(mediaurl);
    update_image(mediaurl);
    update_file();

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

  TextEditingController name_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  TextEditingController about_controller = TextEditingController();
  var date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          trailing: InkWell(
              onTap: () {
                upload_image();
                var keyw = key.currentState!.validate();
                if (keyw) {
                  submit();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data proccessing......")));
                  Navigator.pop(context);
                } else {}
              },
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
        ),
        elevation: 0,
        backgroundColor: HexColor("#0c1b32"),
      ),
      backgroundColor: HexColor("#0c1b32"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRect(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width - 20,
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Edit profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Tra",
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(

                          borderRadius: dg ? BorderRadius.circular(50) : BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 2)),
                      child:
                      
                       dg
                          ?  CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage("${widget.image}"),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    select_image(context);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.white)),
                                    color: Colors.black,
                                    child: Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ):
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Column(
                                children: [
                                  Container(
                                    
                                    child: Image.file(
                                      imagex!,
                                      height: 180,
                                      width: 180,
                                    ),
                                  ),

                                  // SizedBox(width: 10,),

                                  InkWell(
                                    onTap: () {
                                      select_image(context);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(color: Colors.white)),
                                      color: Colors.black,
                                      child: Icon(
                                        Icons.edit,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            
                          
                            
                            ,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextFormField(
                        controller: name_controller,
                        maxLength: 14,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val!.length <= 4 && val.isEmpty && val != null
                                ? "input text may be null"
                                : null,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Tra"),
                        decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.white),
                            prefixIcon: Text("    "),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 13),
                            label: Text("Name"),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.amber,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextFormField(
                        controller: pass_controller,
                        maxLength: 10,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val!.length < 5 && val.isEmpty && val != null
                                ? "position text may be null"
                                : null,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Tra"),
                        decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.white),
                            prefixIcon: Text("    "),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 13),
                            label: Text("Position"),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.amber,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 20,
                      child: TextFormField(
                        controller: about_controller,
                        maxLength: 50,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) =>
                            val!.length < 50 && val.isEmpty && val != null
                                ? "may  be null or lengthy"
                                : null,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "Tra"),
                        decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.white),
                            prefixIcon: Text("    "),
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 13),
                            label: Text("About you"),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.amber,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ))),
                      ),
                    ),
                    ListTile(
                      subtitle: Text(
                        "  (Can't be change)",
                        style: TextStyle(color: Colors.white.withOpacity(0.4)),
                      ),
                      title: Text(" Default Email id  ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Tra")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: HexColor("#0c1b32"),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.email}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Tra")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      subtitle: Text(
                        "( Click on password for change )",
                        style: TextStyle(color: Colors.amber),
                      ),
                      title: Text(" Active Password ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Tra")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: HexColor("#0c1b32"),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: Card(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => forget()));

                              print(date.day);
                              print(date.month);
                              print(date.year);
                              print(
                                  "${date.hour} : ${date.minute} : ${date.second}");
                            },
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${widget.pass}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Tra")),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text("Joined in  ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "Tra")),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: HexColor("#0c1b32"),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey)),
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.join}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Tra")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
