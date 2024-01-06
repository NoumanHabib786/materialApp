import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_app/Providers/toolsProvider.dart';
import 'package:material_app/Providers/userProvider.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:material_app/Widgets/text_fields.dart';
import 'package:material_app/Widgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddToolScreen extends StatefulWidget {
  const AddToolScreen({Key? key}) : super(key: key);

  @override
  State<AddToolScreen> createState() => _AddToolScreenState();
}

class _AddToolScreenState extends State<AddToolScreen> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var specificationController = TextEditingController();
  var applicationController = TextEditingController();
  File? image;
  var db = FirebaseFirestore.instance;

  bool isAdding = false;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

    if (image != null) {
      // Do something with the selected image, such as displaying it or uploading it.
      // For example, you can set the image to a state variable to display it in your UI.
      setState(() {
        this.image = File(image.path);
      });
    } else {
      print("cancel");
    }
  }

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var tools = context.watch<ToolsProvider>();
    return Scaffold(
      appBar: app_bar(title: "Add Tool", autolead: true),
      bottomSheet: bottomCotainer(
          context: context,
          child: Consumer<UserProvider>(
            builder: (context, value, child) {
              return isAdding
                  ? Center(
                      child: loading,
                    )
                  : button_fill(context, "Add", () {
                      if (key.currentState!.validate()) {
                        if (tools.applications.isNotEmpty) {
                          if (tools.specifications.isNotEmpty) {
                            setState(() {
                              isAdding = true;
                            });
                            value
                                .postFileMessage(image!.path, context)
                                .then((imageValue) {
                              value
                                  .addTools(
                                      context: context,
                                      toolApplication: tools.applications,
                                      toolDescription:
                                          descriptionController.text,
                                      toolName: nameController.text,
                                      toolPrice: priceController.text,
                                      toolSpecification: tools.specifications,
                                      toolImage: imageValue)
                                  .then((value) {
                                specificationController.clear();
                                applicationController.clear();
                                tools.applications.clear();
                                tools.specifications.clear();
                                descriptionController.clear();
                                nameController.clear();
                                priceController.clear();
                                image = null;
                                setState(() {});
                                print(tools.applications);
                                UtilsNotify.flushBarErrorMessage(
                                    "Tool added", context);
                                setState(() {
                                  isAdding = false;
                                });
                              }).onError((error, stackTrace) {
                                setState(() {
                                  isAdding = false;
                                });
                              });
                            }).onError((error, stackTrace) {
                              setState(() {
                                isAdding = false;
                              });
                            });
                          } else {
                            UtilsNotify.flushBarErrorMessage(
                                "Please enter some specifications", context);
                          }
                        } else {
                          UtilsNotify.flushBarErrorMessage(
                              "Please enter some applications", context);
                        }
                      }
                    });
            },
          )),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(4),
                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 25.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: image == null
                          ? Text(
                              "Select image  +",
                              style: txt_simple_nunito(),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                                height: 25.h,
                                width: 100.w,
                              ),
                            )),
                ),
                height(2),
                text_field(
                    icon: Container(),
                    onTap: () {},
                    context: context,
                    controller: nameController,
                    hint_text: "Please enter tool name"),
                height(2),
                text_field_Number(
                    context: context,
                    length: 4,
                    controller: priceController,
                    hint_text: "Please enter tool price"),
                height(2),
                text_field_Note(
                    lines: 3,
                    context: context,
                    controller: descriptionController,
                    hint_text: "Please enter tool description"),
                height(2),
                Row(
                  children: [
                    Expanded(
                      child: text_field_Note(
                          lines: 1,
                          context: context,
                          controller: applicationController,
                          hint_text: "Please enter tool applications"),
                    ),
                    width(2),
                    GestureDetector(
                      onTap: () {
                        if (applicationController.text.isNotEmpty) {
                          if (tools.applications.length > 4) {
                            UtilsNotify.flushBarErrorMessage(
                                "You can enter maximum 5 applications",
                                context);
                          } else {
                            tools.addApplications(applicationController);
                            if (tools.applications.length <= 4) {
                              applicationController.clear();
                            } else {
                              applicationController.text =
                                  tools.applications.length.toString();
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(width: 1, color: Colors.grey)),
                        padding: EdgeInsets.all(1.h),
                        child: const Icon(Icons.add),
                      ),
                    )
                  ],
                ),
                height(2),
                Wrap(
                    spacing: 3.w,
                    children: List.generate(
                        tools.applications.length,
                        (index) => InkWell(
                              onTap: () {
                                tools.removeApplications(index);
                              },
                              child: Chip(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(width: 1)),
                                  labelStyle: txt_w500_mont(fontSize: 10.sp),
                                  label: Text(tools.applications[index])),
                            ))),
                Row(
                  children: [
                    Expanded(
                      child: text_field(
                          icon: Container(),
                          onTap: () {},
                          context: context,
                          controller: specificationController,
                          hint_text: "Please enter tool specification"),
                    ),
                    width(2),
                    GestureDetector(
                      onTap: () {
                        if (specificationController.text.isNotEmpty) {
                          if (tools.specifications.length > 4) {
                            UtilsNotify.flushBarErrorMessage(
                                "You can enter maximum 5 specification",
                                context);
                          } else {
                            tools.addSpecification(specificationController);
                            if (tools.specifications.length <= 4) {
                              specificationController.clear();
                            } else {
                              specificationController.text =
                                  tools.specifications.length.toString();
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(width: 1, color: Colors.grey)),
                        padding: EdgeInsets.all(1.h),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                Wrap(
                    spacing: 3.w,
                    children: List.generate(
                        tools.specifications.length,
                        (index) => InkWell(
                              onTap: () {
                                tools.removeSpecification(index);
                              },
                              child: Chip(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(width: 1)),
                                  labelStyle: txt_w500_mont(fontSize: 10.sp),
                                  label: Text(tools.specifications[index])),
                            ))),
                height(10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
