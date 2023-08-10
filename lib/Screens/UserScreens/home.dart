import 'dart:async';

import 'package:card_swiper/card_swiper.dart';
import 'package:material_app/Screens/UserScreens/product_detail_screen.dart';
import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Screens/UserScreens/tools_category.dart';
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
    Timer.periodic(const Duration(seconds: 5), _printTime);
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final willpop = await closeDialogue(context);
        return willpop ?? false;
      },
      child: Scaffold(
        // backgroundColor: Colors.grey.withOpacity(0.1),
        appBar: app_bar(
            autolead: true,
            title: "Construction Material App",
            actions: IconButton(
                onPressed: () {},
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
                list_category(
                  list: materils_list,
                  function: (value) => debugPrint(value.toString()),
                ),
                height(2),
                nameRow(
                    name: "Tools Category",
                    function: () => navigate_push(
                        context: context, next_Screen: const ToolsCategory()),
                    see: "See All"),
                height(1),
                list_category(
                  list: tools_list,
                  function: (value) => navigate_push(
                      context: context,
                      next_Screen: ProductDetailScreen(
                        product_list: tools_list[value],
                      )),
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
                                            style:
                                                txt_w600_mont(fontSize: 12.sp),
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
                                        style: txt_w600_nuito(fontSize: 12.sp),
                                      ),
                                      height(0.5),
                                      Text(
                                        'We ensure the highest quality standards for our materials. Our products undergo rigorous testing and inspection to meet industry benchmarks. Our commitment to quality ensures your construction projects are built to last.',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: txt_simple_mont(fontSize: 10.sp),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
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
      ),
    );
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
          );
        },
      ),
    );
  }
}
