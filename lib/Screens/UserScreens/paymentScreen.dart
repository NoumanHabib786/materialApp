import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_cvc_input_formatter.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sizer/sizer.dart';

import '../../Styles/colors.dart';
import '../../Widgets/button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var cardNumberController = TextEditingController();
  var cardHolderController = TextEditingController();
  var cvcController = TextEditingController();
  var cardExpiryController = TextEditingController();

  // var month;
  //
  // var year;
  //
  // List days = [];
  //
  // void generateDaysInCurrentMonth() {
  //   final now = DateTime.now();
  //   final lastDayOfCurrentMonth = DateTime(now.year, now.month + 1, 0).day;
  //   days = List<String>.generate(
  //     12,
  //     (int index) {
  //       final day = (index + 1).toString().padLeft(2, '0');
  //       return day;
  //     },
  //   );
  // }
  //

  var key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var expiry;
  var selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: "Card Details", autolead: true),
      bottomSheet: bottomCotainer(
          context: context,
          child: button_fill(context, "Pay", () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  title:  Center(
                    child: Text(
                      "Payment",
                      style: txt_w600_mont(),
                    ),
                  ),
                  content: Text(
                    "Payment Successfully paid",
                    textAlign: TextAlign.center,
                    style: txt_w500_mont(),
                  ),
                );
              },
            );
          })),
      // bottomSheet: Consumer<LearnerProvider>(
      //   builder: (context, value, child) {
      //     return ButtonsClass.bottomSheet(
      //       child: ButtonsClass.buildFillButton(
      //           context: context,
      //           btnName: "Continue",
      //           isLoading: value.isLoadingRequest,
      //           function: () {
      //             if (key.currentState!.validate()) {
      //               if (selectedDate != null) {
      //                 DateTime parsedDate =
      //                 DateFormat("MM/yy").parse(selectedDate);
      //                 DateTime currentDate = DateTime.now();
      //                 print(selectedDate);
      //                 if (parsedDate.isAfter(currentDate)) {
      //                   print(" is in the future");
      //                   value.setCardDetails(
      //                       cardHolderController.text,
      //                       cardExpiryController.text,
      //                       cardNumberController.text,
      //                       cvcController.text);
      //                   print(value.postCodes);
      //                   value.addRequestLearner(context);
      //                 } else if (parsedDate.isBefore(currentDate)) {
      //                   print(" is in the past");
      //                   Utils.flushBarErrorMessage(
      //                       "Please select valid date", context);
      //                 } else {
      //                   print(" is the current month/year");
      //                 }
      //               } else {
      //                 Utils.flushBarErrorMessage("Please select date", context);
      //               }
      //             }
      //           }),
      //     );
      //   },
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autofillHints: const ["4242424242424242"],
                  style: txt_w500_mont(fontSize: 11.sp),
                  controller: cardNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter card number";
                    } else if (value.length < 16) {
                      return "Please enter valid number";
                    }
                    return null;
                  },
                  maxLength: 19,
                  inputFormatters: [
                    CreditCardFormatter(),
                    LengthLimitingTextInputFormatter(19)
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: mainBlack.withOpacity(0.1),
                    filled: true,
                    counterStyle: txt_w500_mont(
                      fontSize: 10.sp,
                    ),
                    errorStyle:
                        txt_w500_mont(color: Colors.red, fontSize: 9.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: "Card number",
                    labelStyle: txt_w500_mont(color: mainBlack),
                  ),
                ),
                height(2),
                Text(
                  "Card Expiry",
                  style: txt_w500_mont(fontSize: 11.sp),
                ),
                height(1),
                TextFormField(
                  style: txt_w500_mont(fontSize: 11.sp),
                  controller: cardExpiryController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter card expiry date";
                    }
                    if (value.length < 5) {
                      return "Please enter valid card expiry date";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    selectedDate = value;
                    setState(() {});
                  },
                  inputFormatters: [
                    // CreditCardExpirationDateFormatter(),
                    // LengthLimitingTextInputFormatter(5)
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: mainBlack.withOpacity(0.1),
                    filled: true,
                    counterStyle: txt_w500_mont(
                      fontSize: 10.sp,
                    ),
                    errorStyle:
                        txt_w500_mont(color: Colors.red, fontSize: 9.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: "MM / YY",
                    labelStyle: txt_w500_mont(color: mainBlack),
                  ),
                ),
                height(2),
                TextFormField(
                  style: txt_w500_mont(fontSize: 11.sp),
                  controller: cardHolderController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter card holder name";
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    fillColor: mainBlack.withOpacity(0.1),
                    filled: true,
                    counterStyle: txt_w500_mont(
                      fontSize: 10.sp,
                    ),
                    errorStyle:
                        txt_w500_mont(color: Colors.red, fontSize: 9.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: "Card holder name",
                    labelStyle: txt_w500_mont(color: mainBlack),
                  ),
                ),
                height(2),
                TextFormField(
                  style: txt_w500_mont(fontSize: 11.sp),
                  controller: cvcController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter card CVC number";
                    } else if (value.length < 3) {
                      return "Please enter valid number";
                    }
                    return null;
                  },
                  maxLength: 4,
                  inputFormatters: [
                    CreditCardCvcInputFormatter(isAmericanExpress: true)
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: mainBlack.withOpacity(0.1),
                    filled: true,
                    counterStyle: txt_w500_mont(
                      fontSize: 10.sp,
                    ),
                    errorStyle:
                        txt_w500_mont(color: Colors.red, fontSize: 9.sp),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: "Card CVC number",
                    labelStyle: txt_w500_mont(color: mainBlack),
                  ),
                ),
                height(10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
