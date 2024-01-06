import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_app/Providers/userProvider.dart';
import 'package:material_app/Screens/ServicerScreen/ServiceProfileScreen.dart';
import 'package:material_app/Widgets/app_bar.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/sized_box.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../Styles/colors.dart';
import '../../Styles/text_styles.dart';

class MainServicerScreen extends StatefulWidget {
  const MainServicerScreen({Key? key}) : super(key: key);

  @override
  State<MainServicerScreen> createState() => _MainServicerScreenState();
}

class _MainServicerScreenState extends State<MainServicerScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  fetch() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UserProvider>().getServiceInformation(context, user!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        print(value.firebase!.uid);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "DASHBOARD",
                style: txt_w500_mont(),
              )
                  .animate(
                      // delay: 100.ms,
                      )
                  .fadeIn(delay: 200.ms)
                  .shimmer(duration: 200.ms),
              centerTitle: true,
              backgroundColor: Colors.white,
              leading: value.isServiceLoading
                  ? Container()
                  : InkWell(
                      onTap: () {
                        navigate_push(
                            context: context,
                            next_Screen: const ServiceProfileScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(value.serviceImage ?? ""),
                        ),
                      ),
                    ),
              iconTheme: const IconThemeData(color: mainBlack),
              elevation: 0,
            ),
            body: StreamBuilder(
              stream:
                  value.serviers.where("id", isEqualTo: user!.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No Data Found"),
                  );
                } else {
                  final data =
                      snapshot.data!.docs.first.data() as Map<String, dynamic>;
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(2.h),
                    margin: EdgeInsets.all(4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service Man",
                          style: txt_w600_nuito(),
                        ),
                        height(3),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "${data['image']}",
                              height: 15.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )),
                        height(2),
                        buildRow(txt1: "Name", txt2: "${data['name']}"),
                        buildRow(txt1: "Number", txt2: "${data['number']}"),
                        buildRow(txt1: "Job", txt2: "${data['type']}"),
                        buildRow(txt1: "Status", txt2: "${data['request']}"),
                        height(2),
                        Divider(),
                        Text(
                          "Customer",
                          style: txt_w600_nuito(),
                        ),
                        height(3),
                        data['user'] == null
                            ? Center(
                                child: Text(
                                "Wait for any customer hire you",
                                style: txt_w600_nuito(color: Colors.red),
                              ))
                            : Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        "${data['user']['image']}",
                                        height: 15.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )),
                                  height(2),
                                  buildRow(
                                      txt1: "Name",
                                      txt2: "${data['user']['name']}"),
                                  buildRow(
                                      txt1: "Email",
                                      txt2: "${data['user']['email']}"),
                                  buildRow(
                                      txt1: "Number",
                                      txt2: "${data['user']['number']}"),
                                  buildRow(
                                      txt1: "Age",
                                      txt2: "${data['user']['age']}"),
                                  height(2),
                                ],
                              )
                      ],
                    ),
                  );
                }
              },
            ));
      },
    );
  }

  Row buildRow({String? txt1, String? txt2}) {
    return Row(
      children: [
        Text(
          txt1!,
          style: txt_w500_mont(),
        ),
        Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  txt2!,
                  style: txt_w600_mont(fontSize: 12.sp),
                )))
      ],
    );
  }
}
