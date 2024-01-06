import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../Providers/userProvider.dart';
import '../../Styles/colors.dart';
import '../../Styles/text_styles.dart';
import '../../Widgets/button.dart';
import '../../Widgets/images.dart';
import '../../Widgets/sized_box.dart';
import '../../Widgets/text_fields.dart';
import '../../Widgets/utils.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  var firstNameController = TextEditingController();

  var contactController = TextEditingController();
  var agrController = TextEditingController();
  var locationController = TextEditingController();
  var experienceController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isMale = false;
  File? image;
  bool obs = true;
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
  String? selectedTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userPro, child) {
        return Scaffold(
          appBar: app_bar(title: "Details", autolead: true),
          bottomSheet: bottomCotainer(
            child: userPro.isServiceMan
                ? Center(
                    child: loading,
                  )
                : button_fill(context, "Continue", () {
                    if (key.currentState!.validate()) {
                      if(image!=null){
                        userPro.addServiceMan(
                            email: emailController.text,
                            experience: experienceController.text,
                            location: locationController.text,
                            password: passwordController.text,
                            whichType: selectedTitle,
                            name: firstNameController.text,
                            age: agrController.text,
                            contactNumber: contactController.text,
                            image: image,
                            context: context).then((value) {
                              if(value=="added")
                                {

                                  emailController.clear();
                                  experienceController.clear();
                                  locationController.clear();
                                  passwordController.clear();
                                  firstNameController.clear();
                                  contactController.clear();
                                  agrController.clear();

                                  setState(() {
                                    selectedTitle =null;
                                    image =null;
                                  });
                                }


                        });
                      }
                      else
                        {
                          UtilsNotify.flushBarErrorMessage("Please select image", context);
                        }
                    }
                  }),
            context: context,
          ),
          body: Padding(
            padding: EdgeInsets.all(2.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Fill the field for service!",
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
                    height(2),
                    text_field(
                        onTap: () {},
                        obs: false,
                        context: context,
                        icon: const Icon(Icons.email_outlined),
                        controller: emailController,
                        hint_text: "Enter your email"),
                    height(2),
                    textfieldName(
                        "Enter your name", firstNameController, false),
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
                    text_field_Number(
                        context: context,
                        controller: experienceController,
                        hint_text: "Please enter your experience",
                        length: 2),
                    height(2),
                    text_field_Note(
                      context: context,
                      controller: locationController,
                      keyBoardType: TextInputType.streetAddress,
                      hint_text: "Please enter location",
                    ),
                    height(2),
                    Container(
                      width: 100.w,
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton(
                        hint: Text("Choose Service",
                            style: txt_simple_nunito(
                                color: Colors.grey.shade500,
                                fontSize: 11.sp)),
                        underline: Container(),
                        borderRadius: BorderRadius.circular(12),
                        value: selectedTitle,
                        items: <String>['Plumber', 'Electrician']
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                value: value,
                                child: SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    value,
                                    style: txt_w600_nuito(fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          selectedTitle = value.toString();
                          setState(() {});
                        },
                      ),
                    ),
                    height(2),
                    text_field_password(
                        onTap: () {
                          setState(() {
                            obs = !obs;
                          });
                        },
                        context: context,
                        controller: passwordController,
                        hint_text: "Enter your password",
                        obs: obs),
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
                                  border: Border.all(color: mainBlack)),
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
                                  border: Border.all(color: mainBlack)),
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
              height(10)
            ],
              ),
            ),
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
            borderSide: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(12)),
        errorStyle: txt_simple_nunito(color: Colors.red, fontSize: 9.sp),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1)),
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
