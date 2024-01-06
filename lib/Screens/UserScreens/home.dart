import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_app/Providers/toolsProvider.dart';
import 'package:material_app/Screens/UserScreens/cartScreen.dart';
import 'package:material_app/Screens/toolsScreens/product_detail_screen.dart';
import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Screens/toolsScreens/tools_category.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/dialogue.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/other_widgets.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  String? name;

  HomeScreen({Key? key, this.name}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var page_controller = PageController();
  var vendor_controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), _printTime);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    page_controller.dispose();
  }

  int count = 0;

  void _printTime(Timer timer) {
    if (count < images.length - 1) {
      count++;
    } else {
      count = 0;
    }
    page_controller.animateToPage(
      count,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  Timer? _timer;
  final CollectionReference _usersStream =
      FirebaseFirestore.instance.collection('tools');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      final willpop = await closeDialogue(context);
      return willpop ?? false;
    }, child: Consumer<ToolsProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: app_bar(
              autolead: true,
              title: "Construction Material App",
              actions: IconButton(
                  onPressed: () {
                    navigate_push(context: context, next_Screen: CartScreen(
                    ));
                  },
                  icon: const Icon(
                    CupertinoIcons.shopping_cart,
                    size: 19,
                  ))),
          drawer: const Drawer_Screen(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pageView(
                      page_list: images,
                      controller: page_controller,
                      height_page: 30.h,
                      width_page: 100.w),
                  height(2),
                  Center(
                    child: SmoothPageIndicator(
                        effect: const JumpingDotEffect(
                          activeDotColor: Colors.black,
                          dotWidth: 10,
                          dotHeight: 5,
                        ),
                        controller: page_controller,
                        count: 4),
                  ),
                  height(2),
                  nameRow(
                    name: "Material Category",
                    function: () => null,
                  ),
                  height(1),
                  height(2),
                  nameRow(
                      name: "Tools Category",
                      function: () {
                        _timer?.cancel();
                        navigate_push(
                            context: context,
                            next_Screen: const ToolsCategory());
                      },
                      see: "See All"),
                  height(1),
                  StreamBuilder(
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
                        return Container(
                          alignment: Alignment.center,
                          height: 15.h,
                          width: 100.w,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                toolsList!.length < 8 ? toolsList.length : 8,
                            physics: const BouncingScrollPhysics(),
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      width: 25.w,
                                      height: 10.h,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          toolsList[index]['toolImage']!,
                                          height: 35,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        // alignment: Alignment.centerLeft,
                                        width: 100,
                                        child: Text(
                                          toolsList[index]['toolName']!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: txt_w500_nuito(),
                                        )),
                                    height(1)
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  height(2),
                  nameRow(
                    name: "Top Vendors",
                    function: () => null,
                  ),
                  height(1),
                  SizedBox(
                      height: 34.h,
                      width: 100.w,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    height: 17.h,
                                    width: double.infinity,
                                    child: Image.asset(
                                      images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              "Mian Building Material",
                                              style: txt_w600_mont(
                                                  fontSize: 12.sp),
                                            )),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  CupertinoIcons.star_fill,
                                                  color: Colors.blue,
                                                  size: 16,
                                                ),
                                                width(2),
                                                Text("4.5")
                                              ],
                                            )
                                          ],
                                        ),
                                        height(1),
                                        Text(
                                          "Quality Assurance:",
                                          style:
                                              txt_w600_nuito(fontSize: 12.sp),
                                        ),
                                        height(0.5),
                                        Text(
                                          'We ensure the highest quality standards for our materials. Our products undergo rigorous testing and inspection to meet industry benchmarks. Our commitment to quality ensures your construction projects are built to last.',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style:
                                              txt_simple_mont(fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ).animate(autoPlay: true, effects: [
                            ShimmerEffect(color: Colors.grey, duration: 300.ms),
                            FadeEffect(begin: 0.1, duration: 300.ms),
                          ]);
                        },
                        itemCount: images.length,
                        viewportFraction: 0.9,
                        scale: 0.9,
                      )),
                  height(4)
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  SizedBox pageView({
    required PageController controller,
    required List page_list,
    double? height_page,
    width_page,
  }) {
    return SizedBox(
      // color: Colors.amber,
      width: width_page,
      height: height_page,
      child: PageView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        pageSnapping: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollDirection: Axis.horizontal,
        itemCount: page_list.length,
        // reverse: true,
        padEnds: false,
        onPageChanged: (value) {
          setState(() {
            count = value;
            print(count);
          });
        },
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  page_list[index].toString(),
                  fit: BoxFit.cover,
                )),
          ).animate().fade().slideY(
              begin: 0.5,
              end: 0,
              delay: 100.ms,
              duration: 300.ms,
              curve: Curves.easeInQuart);
        },
      ),
    );
  }
}
