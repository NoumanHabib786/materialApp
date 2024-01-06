import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_app/Providers/userProvider.dart';
import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/sized_box.dart';
import '../../components/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class userModel {
  String? name;
  String? uName;

  userModel({this.name, this.uName});
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<userModel> list = [
    userModel(name: "Name", uName: "Nouman"),
    userModel(name: "Email", uName: "doc@gmail.com"),
    userModel(name: "Phone Number", uName: "123456789"),
  ];

  final UserProvider userProvider = UserProvider();
  final User? user = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: "Profile",autolead: true),
      body: StreamBuilder(
        stream:
            collectionReference.where("id", isEqualTo: user!.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Data Found"),
            );
          } else {
            final data =
                snapshot.data!.docs.first.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(10),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        padding: EdgeInsets.all(0.5.h),
                        child: CircleAvatar(
                          radius: 8.h,
                          backgroundColor: const Color(0x23000000),
                          backgroundImage: NetworkImage(data['image']),
                        ),
                      ),
                      Positioned(
                          right: 2,
                          bottom: 0,
                          child: CircleAvatar(
                              radius: 1.6.h, child: Icon(Icons.edit)))
                    ],
                  ),
                ),
                height(2),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 7),
                        child: Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x23000000),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: ListTile(
                            visualDensity: const VisualDensity(vertical: -4),
                            minVerticalPadding: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            trailing: InkWell(
                              onTap: () {
                                setState(() {});
                                showModalBottomSheet(
                                  isScrollControlled: false,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12))),
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 1, sigmaY: 1),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Card(
                                                  margin: EdgeInsets.zero,
                                                  shape: const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12))),
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    padding:
                                                        EdgeInsets.all(2.h),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(),
                                                        Text(
                                                            "${list[index].name}",
                                                            style:
                                                                txt_w600_nuito()),
                                                        Text("")
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                height(3),

                                                height(3)
                                              ],
                                            ));
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Edit",
                                style: txt_w600_nuito(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ),
                            title: Text(
                              "${list[index].name}",
                              style: txt_w600_nuito(fontSize: 12.sp),
                              maxLines: 1,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                index == 0
                                    ? "${data['name']}"
                                    : index == 1
                                        ? "${data['email']}"
                                        : "${data['number']}",
                                style: txt_w600_nuito(fontSize: 11.sp),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: (){
                    FirebaseAuth.instance.signOut();
                    navigate_remove_untill(context: context, next_Screen: SignInScreen());
                  },
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(2.h),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black),
                    child: Text(
                      "Logout",
                      style: txt_w600_nuito(color: Colors.white),
                    ),
                  ),
                ),
                height(2)
              ],
            );
          }
        },
      ),
    );
  }
}
