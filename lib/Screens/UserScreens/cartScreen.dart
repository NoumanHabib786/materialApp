import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:material_app/Screens/UserScreens/paymentScreen.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/images.dart';
import '../../Widgets/navigators.dart';
import '../../Widgets/sized_box.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CollectionReference _usersStream =
      FirebaseFirestore.instance.collection('addToCart');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(
        autolead: true,
        title: "Cart",
      ),
      bottomSheet: bottomCotainer(
          context: context,
          child: button_fill(context, "Buy", () {
            navigate_push(context: context, next_Screen: const PaymentScreen());
          })),
      body: StreamBuilder(
        stream: _usersStream
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loading);
          } else {
            List<QueryDocumentSnapshot<Object?>> toolsList =
                snapshot.data?.docs ?? [];
            return toolsList.isEmpty
                ? Center(
                    child: Text("Empty!"),
                  )
                : ListView.builder(
                    itemCount: toolsList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(2.h),
                        margin: EdgeInsets.all(2.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: mainBlack.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 40.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        toolsList[index]['tools']['toolImage'],
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(toolsList[index]['tools']['toolName']),
                                    Text(
                                        "Rs-${toolsList[index]['tools']['toolPrice']}"),
                                  ],
                                ),
                                width(2),
                              ],
                            ),
                            Positioned(
                                right: 4,
                                child: InkWell(
                                    onTap: () {
                                      _usersStream
                                          .doc(toolsList[index]['id'])
                                          .delete();
                                    },
                                    child: Icon(
                                      FontAwesome.xmark,
                                      color: Colors.red,
                                    )))
                          ],
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
