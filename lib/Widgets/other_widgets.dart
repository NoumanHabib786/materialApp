import 'package:material_app/Styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:sizer/sizer.dart';

Container list_category({List? list, Function(int value)? function}) {
  return Container(
    alignment: Alignment.center,
    height: 15.h,
    width: 100.w,
    // color: Colors.black.withOpacity(0.1),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list!.length < 8 ? list.length : 8,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            function!(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                width: 25.w,
                height: 10.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    list[index][1],
                    height: 35,
                  ),
                ),
              ),
              Container(
                  // alignment: Alignment.centerLeft,
                  width: 100,
                  child: Text(
                    list[index][0],
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

Row nameRow({String? name, Function? function, String? see}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name!,
        style: txt_w600_mont(fontSize: 11.sp),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: InkWell(
          onTap: () => function!(),
          child: Text(
            see ?? "",
            style: txt_w600_nuito(fontSize: 12.sp),
          ),
        ),
      )
    ],
  );
}
