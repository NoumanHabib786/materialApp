import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:sizer/sizer.dart';

class ToolsCategory extends StatefulWidget {
  const ToolsCategory({Key? key}) : super(key: key);

  @override
  State<ToolsCategory> createState() => _ToolsCategoryState();
}

class _ToolsCategoryState extends State<ToolsCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: app_bar(title: "Tools List", autolead: true),
      body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: tools_list.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12)),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          tools_list[index][1],
                          height: 130,
                          width: 100.w,
                        ),
                      )),
                  height(1),
                  Text(
                    tools_list[index][0],
                    maxLines: 2,
                    style: txt_w600_mont(fontSize: 12.sp),
                  ),
                  height(1),
                  Text(
                    "Rs- ${tools_list[index][2]}",
                    style: txt_w600_nuito(fontSize: 11.sp),
                  )
                ],
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              childAspectRatio: 0.17 / 0.2)),
    );
  }
}
