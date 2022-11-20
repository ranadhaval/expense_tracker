import 'package:first_app/model/forget.dart';
// import 'package:first_app/pages/forget.dart';
import 'package:first_app/model/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:email_validator/email_validator.dart';
import 'package:lottie/lottie.dart';

class Sign_up_h extends StatefulWidget {
  Sign_up_h({Key? key}) : super(key: key);

  @override
  State<Sign_up_h> createState() => _Sign_up_hState();
}

class _Sign_up_hState extends State<Sign_up_h> {
  fire_auth.FirebaseAuth firebaseAuth = fire_auth.FirebaseAuth.instance;

  TextEditingController email_controller = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool circular = true;
  bool ok = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("sign in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontStyle: FontStyle.italic))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              autofillHints: [AutofillHints.email],
              onEditingComplete: () => TextInput.finishAutofillContext(),
              controller: email_controller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) => val != null && EmailValidator.validate(val)
                  ? null
                  : "wrong inputed text",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text(
                    "  Enter email....",
                    style: TextStyle(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: HexColor("#62d5c4"), width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              autofillHints: [AutofillHints.password],
              onEditingComplete: () => TextInput.finishAutofillContext(),
              controller: pass_controller,
              validator: (val) => val!.length > 6 && val != null && !val.isEmpty
                  ? null
                  : "empty",
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: !ok,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          ok = !ok;
                        });
                      },
                      child: ok
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off)),
                  prefixIcon: Icon(Icons.key),
                  label: Text(
                    "  Enter Password... ",
                    style: TextStyle(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: HexColor("#62d5c4"), width: 2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (Builder) => forget()));
                    },
                    child: Text(
                      "Forget password",
                      style:
                          TextStyle(fontSize: 15, color: Colors.green.shade400),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 100,
              child: Card(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        final form = formkey.currentState!.validate();

                        if (form) {
                          print("validate");
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("data processing")));
                        setState(() {
                          circular = true;
                        });
                        try {
                          fire_auth.UserCredential userCredential =
                              await firebaseAuth.signInWithEmailAndPassword(
                                  email: email_controller.text,
                                  password: pass_controller.text);
                          Scaffold(
                              backgroundColor: HexColor("#0c1b32"),
                              body: Center(
                                  child: Lottie.asset("Assets/jj.json",
                                      animate: true)));
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("sign in succesfully")));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (builder) => Home()),
                              (route) => false);

                          setState(() {
                            circular = false;
                          });
                        } catch (e) {
                          setState(() {
                            circular = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                            backgroundColor: Colors.red,
                          ));
                        }

                        setState(() {
                          circular = true;
                        });
                      },
                      child: circular
                          ? Text("Submit",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic))
                          : CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
