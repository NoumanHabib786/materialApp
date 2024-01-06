import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_app/Screens/adminScreens/adminDrawerScree.dart';
import 'package:material_app/Screens/adminScreens/servisersList.dart';
import 'package:material_app/Screens/adminScreens/usersList.dart';
import 'package:material_app/Screens/toolsScreens/tools_cart.dart';
import 'package:material_app/Screens/toolsScreens/tools_category.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:sizer/sizer.dart';

import '../toolsScreens/addTools.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({Key? key}) : super(key: key);

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  CollectionReference servicers =
      FirebaseFirestore.instance.collection('servicers');
  CollectionReference toolsCollection =
      FirebaseFirestore.instance.collection('tools');
  CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('addToCart');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                navigate_push(
                    context: context, next_Screen: const AddToolScreen());
              },
              label: Row(
                children: const [
                  Text("Add tools"),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ],
              ))
          .animate()
          .fadeIn() // uses `Animate.defaultDuration`
          .scale() // inherits duration from fadeIn
          .move(delay: 300.ms, duration: 600.ms),
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: txt_w500_mont(),
        )
            .animate(
                // delay: 100.ms,
                )
            .fadeIn(delay: 200.ms)
            .shimmer(duration: 200.ms),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: mainBlack),
        elevation: 0,
      ),
      drawer: const Admin_Drawer_Screen(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              Row(
                children: [
                  // Expanded(
                  //     child: Container(
                  //   decoration: BoxDecoration(
                  //       color: mainBlack.withOpacity(0.4),
                  //       borderRadius: BorderRadius.circular(12),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //             color: Colors.black,
                  //             blurRadius: 3,
                  //             blurStyle: BlurStyle.outer,
                  //             spreadRadius: 0,
                  //             offset: Offset(0, 0))
                  //       ]),
                  //   child: Column(
                  //     children: [
                  //       height(3),
                  //       Icon(
                  //         CupertinoIcons.person_2_alt,
                  //         size: 5.h,
                  //         color: Colors.white,
                  //       ),
                  //       height(3),
                  //       Text(
                  //         "Vendors: ",
                  //         style: txt_w600_nuito(),
                  //       ),
                  //       height(3),
                  //     ],
                  //   ),
                  // )),
                  // width(4),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: users.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: loading,
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Loading...'));
                        } else {
                          List<QueryDocumentSnapshot<Object?>> usersList =
                              snapshot.data?.docs ?? [];
                          return InkWell(
                            onTap: () => navigate_push(
                                context: context,
                                next_Screen: const UsersList()),
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainBlack.withOpacity(0.2),
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  height(3),
                                  Icon(
                                    CupertinoIcons.person_2_alt,
                                    size: 5.h,
                                    color: Colors.white,
                                  ),
                                  height(3),
                                  Text(
                                    "Users: ${usersList.length}",
                                    style: txt_w600_nuito(),
                                  ),
                                  height(3),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              height(2),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: toolsCollection.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: loading,
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Loading...'));
                        } else {
                          List<QueryDocumentSnapshot<Object?>> toolsList =
                              snapshot.data?.docs ?? [];
                          return InkWell(
                            onTap: () => navigate_push(
                                context: context,
                                next_Screen: const ToolsCategory()),
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainBlack.withOpacity(0.2),
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  height(3),
                                  Icon(
                                    CupertinoIcons.hammer,
                                    size: 5.h,
                                    color: Colors.white,
                                  ),
                                  height(3),
                                  Text(
                                    "Tools: ${toolsList.length}",
                                    style: txt_w600_nuito(),
                                  ),
                                  height(3),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  width(4),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: servicers.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: loading,
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Loading...'));
                        } else {
                          List<QueryDocumentSnapshot<Object?>> serviceList =
                              snapshot.data?.docs ?? [];
                          return InkWell(
                            onTap: () => navigate_push(
                                context: context,
                                next_Screen: const ServicersList()),
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainBlack.withOpacity(0.2),
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  height(3),
                                  Icon(
                                    CupertinoIcons.person_2_alt,
                                    size: 5.h,
                                    color: Colors.white,
                                  ),
                                  height(3),
                                  Text(
                                    "Service Users: ${serviceList.length}",
                                    maxLines: 1,
                                    style: txt_w600_nuito(),
                                  ),
                                  height(3),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              height(2),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: cartCollection.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: loading,
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Loading...'));
                        } else {
                          List<QueryDocumentSnapshot<Object?>> usersList =
                              snapshot.data?.docs ?? [];
                          return InkWell(
                            onTap: () => navigate_push(
                                context: context,
                                next_Screen: const ToolsCart()),
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainBlack.withOpacity(0.2),
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  height(3),
                                  Icon(
                                    CupertinoIcons.cart_fill,
                                    size: 5.h,
                                    color: Colors.white,
                                  ),
                                  height(3),
                                  Text(
                                    "Carts: ${usersList.length}",
                                    style: txt_w600_nuito(),
                                  ),
                                  height(3),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
