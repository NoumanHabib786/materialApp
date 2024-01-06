import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:material_app/Providers/toolsProvider.dart';
import 'package:material_app/Screens/toolsScreens/addTools.dart';
import 'package:material_app/Screens/toolsScreens/product_detail_screen.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Models/toolsModel.dart';

class ToolsCategory extends StatefulWidget {
  const ToolsCategory({Key? key}) : super(key: key);

  @override
  State<ToolsCategory> createState() => _ToolsCategoryState();
}

class _ToolsCategoryState extends State<ToolsCategory> {
  final CollectionReference _usersStream =
      FirebaseFirestore.instance.collection('tools');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ToolsProvider>(
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: app_bar(title: "Tools List", autolead: true),
            body: StreamBuilder(
              stream: _usersStream.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: loading);
                } else {
                  List<QueryDocumentSnapshot<Object?>> toolsList =
                      snapshot.data?.docs ?? [];
                  // List<QueryDocumentSnapshot<Object?>> filteredTools = [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height(2),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (query) {
                            setState(() {
                              // if (query.isNotEmpty) {
                              //   List<QueryDocumentSnapshot<Object?>>
                              //       filteredTools = toolsList
                              //           .where((tool) => tool['toolName']
                              //               .toLowerCase()
                              //               .contains(searchController.text
                              //                   .toLowerCase()))
                              //           .toList();
                              // } else {
                              //   List<QueryDocumentSnapshot<Object?>>
                              //       filteredTools = toolsList;
                              // }
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                            filled: true,
                            hintText: "Search",
                            hintStyle: txt_w400_mont(),
                            prefixIcon: const Icon(CupertinoIcons.search),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {});
                              },
                              child: Icon(
                                CupertinoIcons.xmark,
                                size: 2.5.h,
                              ),
                            ),
                            fillColor: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      height(2),
                      Padding(
                        padding: const EdgeInsets.only(left: 13.0),
                        child: Text(
                          "Tools",
                          style: txt_w500_mont(),
                        ),
                      ),
                      height(2),
                      Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(12),
                            itemCount: toolsList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(toolsList[index]['id']);
                                  navigate_push(
                                      context: context,
                                      next_Screen: ProductDetailScreen(
                                        toolId: toolsList[index]['id'],
                                      ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: AnimateList(
                                          interval: 300.ms,
                                          effects: [
                                            ShimmerEffect(
                                                color: Colors.grey,
                                                duration: 300.ms),
                                            FadeEffect(
                                                begin: 0.1, duration: 300.ms),
                                          ],
                                          children: [
                                            Container(
                                                margin: EdgeInsets.all(1.h),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  color: Colors.white,
                                                ),
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      toolsList[index]
                                                          ['toolImage'],
                                                      height: 130,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ))),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "Rs-${toolsList[index]['toolPrice']}",
                                                style: txt_w600_nuito(
                                                    fontSize: 11.sp,
                                                    color: Colors.red),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "${toolsList[index]['toolName']}",
                                                maxLines: 2,
                                                style: txt_w600_mont(
                                                    fontSize: 12.sp),
                                              ),
                                            ),
                                            height(2),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: SizedBox(
                                                  height: 5.h,
                                                  child: black_button(
                                                      function: () {
                                                        navigate_push(
                                                            context: context,
                                                            next_Screen:
                                                                ProductDetailScreen(
                                                              toolId: toolsList[
                                                                  index]['id'],
                                                            ));
                                                      },
                                                      load: false,
                                                      btn_name: "Add to Cart")),
                                            )
                                          ])),
                                ),
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.13 / 0.2)),
                      ),
                    ],
                  );
                }
              },
            ));
      },
    );
  }
}
