import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Styles/text_styles.dart';
import 'package:material_app/Widgets/button.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sizer/sizer.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({Key? key}) : super(key: key);

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}


class _OnBordingScreenState extends State<OnBordingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget images(String index) {
    return Image.asset(
      index,
      fit: BoxFit.cover,
      width: 100.w,
      height: 80.h,
    );
  }

  var pageDecore = PageDecoration(
      imageFlex: 6,
      bodyAlignment: Alignment.center,
      bodyFlex: 2,
      titleTextStyle:
          GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 15.sp),
      bodyTextStyle: GoogleFonts.nunito());

  @override
  Widget build(BuildContext context) {
    _onDone() {
      return navigate_remove_untill(context: context, next_Screen: const SignInScreen());
    }
    return IntroductionScreen(
      key: introKey,
      isProgress: true,
      resizeToAvoidBottomInset: true,
      done: button_outline(() => _onDone(),'Next'),
      onDone: () => _onDone(),
      next: const Icon(
        Icons.arrow_forward,
        color: Color(0xff1d3072),
      ),
      back: const Icon(
        Icons.arrow_back,
        color: Color(0xff1d3072),
      ),
      skip: Text(
        "Skip",
        style: txt_w500_mont(fontSize: 12.sp),
      ),
      onSkip: () => _onDone(),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      pages: [
        PageViewModel(
            decoration: pageDecore,
            title: 'Building Dreams Together',
            body: ' Welcome to our Construction Building App!',
            image: Align(
                alignment: Alignment.topCenter,
                child: images("assets/images/intro_image1.jpg"))),
        PageViewModel(
          title: "Join",
          body:
              "Join our Construction Material App community and discover a seamless way to source and manage your building supplies.",
          image: Align(
              alignment: Alignment.topCenter,
              child: images("assets/images/intro_image2.jpg")),
          decoration: pageDecore,
        ),
        PageViewModel(
            title: "Register",
            body:
                "Register now to explore our vast catalog of construction materials, featuring everything from concrete and steel to tiles and insulation",
            image: Align(
                alignment: Alignment.topCenter,
                child: images("assets/images/intro_image3.jpg")),
            decoration: pageDecore),
      ],
    );
  }


}
