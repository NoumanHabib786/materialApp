import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:sizer/sizer.dart';

class ProductDetailScreen extends StatefulWidget {
  List? product_list;

  ProductDetailScreen({Key? key, this.product_list}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var product = widget.product_list;
    return Scaffold(
      appBar: app_bar(title: product![0], autolead: true),
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
                  child: Image.asset(product[1]),
                ),
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
                        product[0],
                        style: txt_w600_nuito(),
                      ),
                      Text(
                        "Rs- ${product[2]}",
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
                        fontSize: 11.sp, color: Colors.grey.shade400),
                  ),
                  Text(
                    product[3],
                    style: txt_w500_mont(fontSize: 11.sp),
                  ),
                  height(2),
                  Text(
                    "SPECIFICATIONS",
                    style: txt_w600_mont(
                        fontSize: 11.sp, color: Colors.grey.shade400),
                  ),
                  Wrap(
                    children: (product[4]as List<String>).map((e) {
                      return Chip(label: Text(e));
                    }).toList(),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
