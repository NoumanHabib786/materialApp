import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_app/Providers/userProvider.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:material_app/Widgets/firebase_variables.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/utils.dart';

class ServicesList extends StatefulWidget {
  const ServicesList({Key? key}) : super(key: key);

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  bool isComplete = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: app_bar(title: "Services", autolead: true),
          body: Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              children: [
                TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelPadding: EdgeInsets.all(1.h),
                    indicator: BoxDecoration(
                        color: mainBlack,
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    labelStyle: txt_w600_nuito(fontSize: 12.sp),
                    unselectedLabelStyle: txt_w500_mont(),
                    tabs: const [
                      Text(
                        "Hiring",
                      ),
                      Text("Ongoing "),
                      Text("Complete "),
                    ]),
                height(2),
                const Expanded(
                  child: TabBarView(children: [
                    HireServices(),
                    OnGoingServices(),
                    CompleteServices()
                  ]),
                )
              ],
            ),
          )),
    );
  }
}

class HireServices extends StatefulWidget {
  const HireServices({Key? key}) : super(key: key);

  @override
  State<HireServices> createState() => _HireServicesState();
}

class _HireServicesState extends State<HireServices> {
  final CollectionReference _usersStream =
      FirebaseFirestore.instance.collection('servicers');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream.where("request", isEqualTo: "pending").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loading);
        }

        List<QueryDocumentSnapshot<Object?>> documents =
            snapshot.data?.docs ?? [];

        return ListView(
          children: documents!.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.all(2.h),
              padding: EdgeInsets.all(2.h),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: mainBlack.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      width(2),
                      Expanded(
                        child: SizedBox(
                          height: 16.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                data['image'],
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ],
                  ),
                  height(3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRow(txt1: "Name", txt2: data['name']),
                      height(2),
                      buildRow(txt1: "Age", txt2: data['age']),
                      height(1),
                      buildRow(txt1: "Experience", txt2: data['experience']),
                      height(1),
                      buildRow(txt1: "Location", txt2: data['location']),
                      height(1),
                      buildRow(txt1: "Service", txt2: data['type']),
                      height(1),
                      Consumer<UserProvider>(
                        builder: (context, userPro, child) {
                          return button_outline(() {
                            print(FirebaseAuth.instance.currentUser!.uid);
                            userPro.users
                                .where('id',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser!.uid)
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              Map<String, dynamic> userData =
                                  querySnapshot.docs.first.data()
                                      as Map<String, dynamic>;
                              Map<String, dynamic> updateData = {
                                "user": userData,
                                "request": "OnGoing"
                              };

                              UtilsNotify.flushBarErrorMessage(
                                  "You have hire this service", context);
                              userPro.serviers
                                  .doc(data['id'])
                                  .update(updateData)
                                  .then((updatedValue) {
                                userPro.addUserService(
                                    context: context,
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    serviceDetails: data,
                                    serviceId: data['id'],
                                    userDetails: userData);
                              });
                            });
                          }, "Hire me");
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Row buildRow({String? txt1, String? txt2}) {
    return Row(
      children: [
        Text(
          txt1!,
          style: txt_w500_mont(),
        ),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  txt2!,
                  style: txt_w600_mont(fontSize: 12.sp),
                )))
      ],
    );
  }
}

class OnGoingServices extends StatefulWidget {
  const OnGoingServices({Key? key}) : super(key: key);

  @override
  State<OnGoingServices> createState() => _OnGoingServices();
}

class _OnGoingServices extends State<OnGoingServices> {
  final CollectionReference _usersStream =
      FirebaseFirestore.instance.collection('userWithServices');
  FirebaseAuth auths = FirebaseAuth.instance;
  bool isComplete = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream
          .where("userId", isEqualTo: auths.currentUser!.uid)
          .where("status", isEqualTo: "pending")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loading);
        }

        List<QueryDocumentSnapshot<Object?>> documents =
            snapshot.data?.docs ?? [];

        return ListView(
          children: documents!.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.all(2.h),
              padding: EdgeInsets.all(2.h),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: mainBlack.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      width(2),
                      Expanded(
                        child: SizedBox(
                          height: 16.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                data['service']['image'],
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ],
                  ),
                  height(3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRow(txt1: "Name", txt2: data['service']['name']),
                      height(2),
                      buildRow(txt1: "Age", txt2: data['service']['age']),
                      height(1),
                      buildRow(
                          txt1: "Experience",
                          txt2: data['service']['experience']),
                      height(1),
                      buildRow(
                          txt1: "Location", txt2: data['service']['location']),
                      height(1),
                      buildRow(txt1: "Service", txt2: data['service']['type']),
                      buildRow(txt1: "Service", txt2: data['service']['number']),
                      height(1),
                      Consumer<UserProvider>(
                        builder: (context, userPro, child) {
                          return button_outline(() {
                            setState(() {
                               isComplete = true;
                            });
                            Map<String, dynamic> updateData = {
                              "request": "pending",
                              'user': null
                            };
                            Map<String, dynamic> updateUserService = {
                              "status": "complete",
                            };
                            UtilsNotify.flushBarErrorMessage(
                                "You have Complete this service", context);
                            print(data['service']['id']);
                            print(data['id']);
                            userPro.serviers
                                .doc(data['id'])
                                .update(updateData)
                                .then((updatedValue) {
                                  print("Update");
                              userPro.userServices
                                  .doc(data['id'])
                                  .update(updateUserService).then((value) {
                                setState(() {
                                  isComplete = false;
                                });
                              }).onError((error, stackTrace) {
                                UtilsNotify.flushBarErrorMessage("Try Again", context);
                                print(error);
                                setState(() {
                                  isComplete = false;
                                });
                              });
                            }).onError((error, stackTrace) {
                              UtilsNotify.flushBarErrorMessage("Try Again", context);
                              print(error);
                              setState(() {
                                isComplete = false;
                              });
                            });
                          }, "Complete");
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Row buildRow({String? txt1, String? txt2}) {
    return Row(
      children: [
        Text(
          txt1!,
          style: txt_w500_mont(),
        ),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  txt2!,
                  style: txt_w600_mont(fontSize: 12.sp),
                )))
      ],
    );
  }
}

class CompleteServices extends StatefulWidget {
  const CompleteServices({Key? key}) : super(key: key);

  @override
  State<CompleteServices> createState() => _CompleteServices();
}

class _CompleteServices extends State<CompleteServices> {
  final CollectionReference _usersStream =
      FirebaseFirestore.instance.collection('userWithServices');
  FirebaseAuth auths = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream
          .where("userId", isEqualTo: auths.currentUser!.uid)
          .where("status", isEqualTo: "complete")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loading);
        }

        List<QueryDocumentSnapshot<Object?>> documents =
            snapshot.data?.docs ?? [];
        return ListView(
          children: documents.map((e) {
            Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.all(2.h),
              padding: EdgeInsets.all(2.h),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: mainBlack.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      width(2),
                      Expanded(
                        child: SizedBox(
                          height: 16.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                data['service']['image'],
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ],
                  ),
                  height(3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRow(txt1: "Name", txt2: data['service']['name']),
                      height(2),
                      buildRow(txt1: "Age", txt2: data['service']['age']),
                      height(1),
                      buildRow(
                          txt1: "Experience",
                          txt2: data['service']['experience']),
                      height(1),
                      buildRow(
                          txt1: "Location", txt2: data['service']['location']),
                      height(1),
                      buildRow(txt1: "Service", txt2: data['service']['type']),
                      height(1),
                      Consumer<UserProvider>(
                        builder: (context, userPro, child) {
                          return button_outline(() {
                            Map<String, dynamic> updateData = {
                              "request": "Completed"
                            };

                            UtilsNotify.flushBarErrorMessage(
                                "You have Complete this service", context);
                            print(data['service']['id']);
                            // userPro.serviers
                            //     .doc(data['service']['id'])
                            //     .update(updateData)
                            //     .then((updatedValue) {
                            //
                            // });
                          }, "Complete");
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Row buildRow({String? txt1, String? txt2}) {
    return Row(
      children: [
        Text(
          txt1!,
          style: txt_w500_mont(),
        ),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  txt2!,
                  style: txt_w600_mont(fontSize: 12.sp),
                )))
      ],
    );
  }
}
