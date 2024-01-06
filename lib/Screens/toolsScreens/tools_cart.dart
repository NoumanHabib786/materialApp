import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/images.dart';

class ToolsCart extends StatefulWidget {
  const ToolsCart({Key? key}) : super(key: key);

  @override
  State<ToolsCart> createState() => _ToolsCartState();
}

class _ToolsCartState extends State<ToolsCart> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('addToCart').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: "Carts", autolead: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loading);
          }

          List<QueryDocumentSnapshot<Object?>> documents =
              snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var tool = documents[index]['tools'];
              var user = documents[index]['user'];
              return Container(
                  margin: EdgeInsets.all(2.h),
                  padding: EdgeInsets.all(2.h),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: mainBlack.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          tool['toolImage'],
                          height: 15.h,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      ),
                      height(2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${tool['toolName']}",
                            style: txt_w500_mont(),
                          ),
                          Text(
                            "Rs-${tool['toolPrice']}",
                            style: txt_w500_nuito(),
                          ),
                        ],
                      ),
                      height(1),
                      Text(
                        "Description",
                        style: txt_w700_nuito(fontSize: 11.sp),
                      ),
                      height(1),
                      Text(
                        "${tool['toolDescription']}",
                        style: txt_w600_nuito(fontSize: 11.sp),
                      ),
                      height(1),
                      // Text(
                      //   "Specification",
                      //   style: txt_w700_nuito(fontSize: 11.sp),
                      // ),
                      //
                      // Wrap(
                      //   spacing: 2.w,
                      //   children: List.generate(
                      //       tool['toolSpecification'].length, (sIndex) {
                      //     return Chip(
                      //         elevation: 2,
                      //         backgroundColor: mainBlack.withOpacity(0.2),
                      //         shape: RoundedRectangleBorder(
                      //             side: BorderSide(width: 1),
                      //             borderRadius: BorderRadius.circular(12)),
                      //         label: Text(tool['toolSpecification'][sIndex],style: txt_w500_nuito(),));
                      //   }),
                      // )
                      Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          collapsedIconColor: mainBlack,
                          initiallyExpanded: index==0?true:false,
                            tilePadding: EdgeInsets.zero,
                            childrenPadding: EdgeInsets.zero,
                            title: Text("Customer Details",style: txt_w600_nuito(fontSize: 12.sp),),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 30.w,
                                height: 12.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: user['image']==null?Icon(CupertinoIcons.person): Image.network(
                                    user['image'],
                                    height: 15.h,
                                    width: double.maxFinite,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              width(3),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user['name'],style: txt_w600_nuito(fontSize: 12.sp),),
                                  Text(user['email']??"sc",style: txt_w600_nuito(fontSize: 12.sp),),
                                  Text(user['number'],style: txt_w600_nuito(fontSize: 12.sp),),
                                  Text(user['age'],style: txt_w600_nuito(fontSize: 12.sp),),

                                ],
                              )
                            ],
                          )
                        ],
                        ),
                      )
                    ],
                  ));
            },
          );
        },
      ),
    );
  }
}
