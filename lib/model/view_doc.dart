import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class doc_view extends StatefulWidget {
  String img;

  doc_view(this.img);

  @override
  State<doc_view> createState() => _doc_viewState();
}

class _doc_viewState extends State<doc_view> {
  bool gg = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.img == "") {
      setState(() {
        gg = false;
      });
    } else {
      setState(() {
        gg = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    gg ?
   
    Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.black)),
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width - 10,
            child: Image(image: NetworkImage("${widget.img}")),
          ),
        ),
      ),
    ) :Scaffold(
              backgroundColor: HexColor("#0c1b32"),
              body:
                  Center(child: Lottie.asset("Assets/jj.json", animate: true)));
  }
}
