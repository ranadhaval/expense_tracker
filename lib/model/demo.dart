import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView(scrollDirection: Axis.horizontal, children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: TabBar(
                      physics: AlwaysScrollableScrollPhysics(),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      controller: controller,
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Text("tab 2")],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Text("tab 10")],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Text("tab 2")],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Text("tab 10")],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Text("tab 2")],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Text("tab 10")],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [Text("tab 2")],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [Text("tab 2")],
                        //   ),
                        // )
                      ]),
                ),
              ),
            ]),
      
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: MediaQuery.of(context).size.height / 1.66,
            //     width: MediaQuery.of(context).size.width - 20,
            //     child: Column(
            //       children: [
            //         Container(
      
            //             margin: EdgeInsets.all(5),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 color: Colors.white12,
            //               ),
            //               height: MediaQuery.of(context).size.height / 1.9,
            //           child: TabBarView(controller: controller, children: [
            //               Container(
            //                         // margin: EdgeInsets.all(5),
            //                         // padding: EdgeInsets.all(),
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(5),
            //                           color: Colors.white12,
            //                         ),
            //                         child: Column(
            //                             mainAxisAlignment: MainAxisAlignment.center,
            //                             children: [
            //                         Text("data"),
            //                             ]),
            //                       ),
      
            //                          Container(
            //                         // margin: EdgeInsets.all(5),
            //                         // padding: EdgeInsets.all(10),
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(5),
            //                           color: Colors.white12,
            //                         ),
            //                         child: Column(
            //                             mainAxisAlignment: MainAxisAlignment.center,
            //                             children: [
            //                                Text("data"),
            //                             ]),
            //                       ),
      
            //           ]),
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
