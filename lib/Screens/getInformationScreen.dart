import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_app/Providers/userProvider.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/images.dart';
import 'package:material_app/Widgets/text_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:icons_plus/icons_plus.dart';

import '../Styles/colors.dart';
import '../Widgets/button.dart';
import '../Widgets/sized_box.dart';
import '../Widgets/utils.dart';

class GetInfoScreen extends StatefulWidget {
  final String? email;

  const GetInfoScreen({Key? key, this.email}) : super(key: key);

  @override
  State<GetInfoScreen> createState() => _GetInfoScreenState();
}

class _GetInfoScreenState extends State<GetInfoScreen> {
  @override
  var firstNameController = TextEditingController();

  var contactController = TextEditingController();
  var agrController = TextEditingController();
  bool isMale = false;
  bool isCheck = false;
  File? image;

  var isMale1 = "Male";

  String phoneNumber = '';

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 10,
      );

      if (image == null) return;

      setState(() {
        this.image = File(image.path);
      });
    } on PlatformException catch (e) {
      print("Error picking image: $e");
    }
  }

  var key = GlobalKey<FormState>();

  String number = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userPro, child) {
        return Scaffold(
          appBar: app_bar(title: "Details"),
          bottomSheet: bottomCotainer(
            child: button_fill(context, "Continue", () {
              if (key.currentState!.validate()) {
                if (!isCheck) {
                  var terms = isCheck ? "false" : "true";
                  userPro.postFileMessage(image!.path , context).then((value) {
                    print(value);
                    userPro.addUser(
                      email: FirebaseAuth.instance.currentUser?.email,
                      name: firstNameController.text,
                      age: agrController.text,
                      contactNumber: contactController.text,
                      image: value,
                      terms: terms,
                      context: context
                    );
                  });
                } else {
                  UtilsNotify.flushBarErrorMessage(
                      "Terms and conditions", context);
                }
              }
            }),
            context: context,
          ),
          body: Padding(
            padding: EdgeInsets.all(2.h),
            child: Form(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Fill the requirements!",
                      textAlign: TextAlign.center,
                      style: txt_w600_nuito(),
                    ),
                  ),
                  height(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          buildShowImage(context);
                        },
                        child: Container(
                            height: 15.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: image == null
                                ? Icon(
                                    CupertinoIcons.person_circle_fill,
                                    size: 10.h,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ))),
                      ),
                      SizedBox(
                        width: 34.w,
                        height: 5.h,
                        child: button_outline(
                          () {
                            buildShowModalBottomSheet(context);
                          },
                          "Select image",
                        ),
                      ),
                    ],
                  ),
                  height(2),
                  Form(
                    key: key,
                    child: Column(
                      children: [
                        textfieldName("Enter your name", firstNameController, false),
                        height(2),
                        text_field_Number(
                            context: context,
                            controller: contactController,
                            hint_text: "Please enter contact number",
                            length: 11),
                        height(2),
                        text_field_Number(
                            context: context,
                            controller: agrController,
                            hint_text: "Please enter your age",
                            length: 2),
                        height(2),
                      ],
                    ),
                  ),
                  height(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Select Gender",
                          style: txt_w400_nuito(),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isMale = true;
                                isMale1 = "Male";
                                print(isMale1);
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(isMale ? 0.3.h : 0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: isMale
                                              ? Colors.orange
                                              : mainBlack)),
                                  child: CircleAvatar(
                                      backgroundColor: isMale
                                          ? mainBlack
                                          : Colors.transparent,
                                      child: Image.asset(
                                        maleIcon,
                                        height: isMale ? 3.5.h : 3.h,
                                      )),
                                ),
                                Text(
                                  "Male",
                                  style: txt_w400_nuito(
                                      fontWeight: isMale
                                          ? FontWeight.w700
                                          : FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          width(3),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isMale = false;
                                isMale1 = "Female";
                                print(isMale1);
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(!isMale ? 0.3.h : 0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: !isMale
                                              ? Colors.orange
                                              : mainBlack)),
                                  child: CircleAvatar(
                                      backgroundColor: !isMale
                                          ? mainBlack
                                          : Colors.transparent,
                                      child: Image.asset(
                                        femaleIcon,
                                        height: !isMale ? 3.5.h : 3.h,
                                      )),
                                ),
                                Text(
                                  "Female",
                                  style: txt_w400_nuito(
                                      fontWeight: !isMale
                                          ? FontWeight.w700
                                          : FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  height(2),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isCheck = !isCheck;
                      });
                    },
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isCheck = !isCheck;
                            });
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              height: 3.5.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                height: 5.h,
                                padding: EdgeInsets.all(0.2.h),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color:
                                            isCheck ? mainBlack : Colors.orange,
                                        width: 1)),
                                child: CircleAvatar(
                                  backgroundColor:
                                      isCheck ? Colors.transparent : mainBlack,
                                  child: isCheck
                                      ? const Text("")
                                      : const Icon(FontAwesome.check,
                                          size: 13, color: Colors.white),
                                ),
                              )),
                        ),
                        width(3),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {},
                          child: Text(
                            "Terms and conditions",
                            style: txt_w400_nuito(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  height(10)
                ],
              ),
            )),
          ),
        );
      },
    );
  }

  TextFormField textfieldName(
      String message, TextEditingController controller, bool? readOnly) {
    return TextFormField(
      readOnly: readOnly ?? false,
      style: txt_simple_nunito(fontSize: 11.sp),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return message;
        } else if (value.length < 3) {
          return "Please enter at least 3 letters";
        }
        return null;
      },
      maxLength: 25,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
      ],
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        filled: true,
        counterStyle: txt_simple_nunito(fontSize: 9.sp),
        labelStyle: txt_simple_nunito(),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1),
          borderRadius: BorderRadius.circular(12)
        ),
        errorStyle: txt_simple_nunito(color: Colors.red, fontSize: 9.sp),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 1)),
        labelText: message,
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Choose Picture",
                style: txt_simple_nunito(
                  fontSize: 14.sp,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: button_fill(
                        context,
                        "Camera",
                        () {
                          Navigator.pop(context);
                          pickImage(ImageSource.camera);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: button_fill(
                        context,
                        "Gallery",
                        () {
                          Navigator.pop(context);
                          pickImage(ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> buildShowImage(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "View Picture",
                style: txt_simple_nunito(
                  fontSize: 14.sp,
                ),
              ),
              height(2),
              image == null
                  ? const Text("Select Image")
                  : InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          width: 100.w,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Text(
                            "View Image",
                            style: txt_simple_nunito(fontSize: 11.sp),
                          )),
                    )
            ],
          ),
        );
      },
    );
  }
}
