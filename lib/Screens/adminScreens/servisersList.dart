import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:sizer/sizer.dart';

class ServicersList extends StatefulWidget {
  const ServicersList({Key? key}) : super(key: key);

  @override
  State<ServicersList> createState() => _ServicersListState();
}

class _ServicersListState extends State<ServicersList> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('servicers').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: "Servicers List", autolead: true),
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
                child: Row(
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
                    width(3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            style: txt_w600_nuito(),
                          ),
                          height(2),
                          Text(
                            data['age'],
                            style: txt_w400_mont(fontSize: 11.sp),
                          ),
                          height(1),
                          Text(
                            data['number'],
                            style: txt_w400_mont(fontSize: 11.sp),
                          ),
                          height(1),
                          Text(
                            data['experience'],
                            style: txt_w400_mont(fontSize: 11.sp),
                          ),
                          height(1),
                          Text(
                            data['location'],
                            style: txt_w400_mont(fontSize: 11.sp),
                          ),
                          height(1),
                          Text(
                            data['type'],
                            style: txt_w400_mont(fontSize: 11.sp),
                          ),
                          height(1),
                          Text(
                            data['request'],
                            style: txt_w600_mont(fontSize: 11.sp),
                          ),
                          height(1),
                          Text(
                            data['email'],
                            style: txt_w400_mont(fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
