import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Screens/UserScreens/tools_category.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/firebase_variables.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Drawer_Screen extends StatefulWidget {
  const Drawer_Screen({Key? key}) : super(key: key);

  @override
  State<Drawer_Screen> createState() => _Drawer_ScreenState();
}

class _Drawer_ScreenState extends State<Drawer_Screen> {
  List drawer_list = [
    ["Construction Tools", tools],
    ["Construction Material", material],
    ["Services", services]
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 70.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.withOpacity(0.3),
                child: Column(
                  children: [
                    height(5),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(0.5.h),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.black)),
                        child: CircleAvatar(
                          radius: 8.5.h,
                          backgroundColor: Colors.transparent,
                          backgroundImage: const AssetImage(
                              "assets/images/construction.jpg"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        "Nouman Mughal ",
                        style: txt_w500_mont(),
                      ),
                    ),
                    height(0.5),
                    SizedBox(
                      height: 4.h,
                      child: Text(
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        user == null
                            ? "nouman@gmail.com"
                            : user!.email.toString(),
                        style: txt_simple_mont(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    // padding: EdgeInsets.all(8),
                    itemCount: drawer_list.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: 8.h,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              if(index ==0)
                                {
                                  Navigator.pop(context);
                                  navigate_push(context: context, next_Screen: ToolsCategory());
                                }

                            });
                          },
                          minLeadingWidth: 10,
                          leading: Image.asset(
                            drawer_list[index][1].toString(),
                            width: 17,
                          ),
                          title: Text(
                            drawer_list[index][0],
                            style: txt_w500_nuito(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            InkWell(
              onTap: () {
                auth.signOut();
                navigate_remove_untill(
                    context: context, next_Screen: SignInScreen());
              },
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 6.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.logout,
                        size: 15,
                        color: Colors.white,
                      ),
                      width(1),
                      Text(
                        "Log Out",
                        style: txt_simple_nunito(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
