import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:material_app/Models/toolsModel.dart';
import 'package:material_app/Providers/userProvider.dart';
import 'package:material_app/Screens/UserScreens/cartScreen.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:material_app/Widgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/images.dart';

class ProductDetailScreen extends StatefulWidget {
  String? toolId;

  ProductDetailScreen({Key? key, this.toolId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CollectionReference _usersStream =
      FirebaseFirestore.instance.collection('tools');

  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersStream.where("id", isEqualTo: widget.toolId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loading);
        } else {
          final data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: app_bar(
              title: data['toolName'],
              autolead: true,
            ),
            bottomSheet: Consumer<UserProvider>(
              builder: (context, userPro, child) {
                return bottomCotainer(
                  context: context,
                  child: isAdded
                      ? Center(
                          child: loading,
                        )
                      : button_fill(context, "Add to Cart", () {
                          setState(() {
                            isAdded = true;
                          });
                          UtilsNotify.flushBarErrorMessage("Added Successfully", context);
                          userPro.users
                              .where('id',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then((QuerySnapshot querySnapshot) {
                            Map<String, dynamic> userData =
                                querySnapshot.docs.first.data()
                                    as Map<String, dynamic>;

                            userPro
                                .addToCart(
                                    context: context,
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    tool: data,
                                    toolId: data['id'],
                                    user: userData)
                                .then((value) {

                              setState(() {
                                isAdded = false;
                              });
                            }).onError((error, stackTrace) {
                              setState(() {
                                isAdded = false;
                              });
                            });
                          }).onError((error, stackTrace) {
                            setState(() {
                              isAdded = false;
                            });
                          });

                          // cartItems.add(productCart);
                        }),
                );
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FullScreenWidget(
                    disposeLevel: DisposeLevel.Low,
                    child: Center(
                      child: Container(
                          height: 25.h,
                          width: 100.w,
                          color: Colors.grey.shade100,
                          child: Image.network(
                            data['toolImage'],
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  height(2),
                  Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['toolName'],
                              style: txt_w600_nuito(),
                            ),
                            Text(
                              "Rs- ${data['toolPrice']}",
                              style: txt_w600_nuito(fontSize: 13.sp),
                            ),
                          ],
                        ),
                        height(2),
                        Center(
                          child: Text(
                            "DESCRIPTION & SPECIFICATIONS",
                            style: txt_w600_mont(
                                fontSize: 11.sp, color: Colors.grey.shade400),
                          ),
                        ),
                        height(2),
                        Text(
                          "DESCRIPTION",
                          style: txt_w600_mont(
                              fontSize: 10.sp, color: Colors.grey.shade400),
                        ),
                        Text(
                          data['toolDescription'],
                          style: txt_w500_mont(fontSize: 11.sp),
                        ),
                        height(2),
                        Text(
                          "SPECIFICATIONS",
                          style: txt_w600_mont(
                              fontSize: 10.sp, color: Colors.grey.shade400),
                        ),
                        Wrap(
                            spacing: 2.w,
                            children: List.generate(
                                data['toolApplication']!.length, (sindex) {
                              return Chip(
                                  elevation: 3,
                                  labelStyle:
                                      txt_simple_nunito(fontSize: 10.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  label: Text(data['toolApplication'][sindex]
                                      .toString()));
                            })),
                        Text(
                          "APPLICATIONS",
                          style: txt_w600_mont(
                              fontSize: 10.sp, color: Colors.grey.shade400),
                        ),
                        Wrap(
                            spacing: 2.w,
                            children: List.generate(
                                data['toolSpecification'].length, (aindex) {
                              return Chip(
                                  elevation: 3,
                                  labelStyle:
                                      txt_simple_nunito(fontSize: 10.sp),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  label: Text(
                                      "${data['toolApplication'][aindex]}"));
                            })),
                        height(2),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
