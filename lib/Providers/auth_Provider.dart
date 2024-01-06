import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_app/Screens/ServicerScreen/mainServicerScreen.dart';
import 'package:material_app/Screens/UserScreens/home.dart';
import 'package:material_app/Screens/UserScreens/sign_in.dart';
import 'package:material_app/Screens/adminScreens/mainScreen.dart';
import 'package:material_app/Screens/getInformationScreen.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/utils.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  CollectionReference servicers =
      FirebaseFirestore.instance.collection('servicers');

  bool signInLoad = false;

  setSignInLoad(bool setLoad) {
    signInLoad = setLoad;
    notifyListeners();
  }

  signIn({
    required BuildContext context,
    TextEditingController? email,
    pass,
  }) {
    setSignInLoad(true);
    auth
        .signInWithEmailAndPassword(
      email: email!.text,
      password: pass.text,
    )
        .then((value) {
          print( value.user!.uid);
      setSignInLoad(false);
      users
          .where('id', isEqualTo: value.user!.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          print(userData['role']);
          print(userData['id']);
          if (userData['role'] == "admin") {
            navigate_remove_untill(
                context: context, next_Screen: const MainAdminScreen());
          } else if (userData['role'] == "Service") {
            navigate_remove_untill(
                context: context, next_Screen: const MainServicerScreen());
          } else {
            navigate_remove_untill(
                context: context,
                next_Screen: HomeScreen(
                  name: userData['name'],
                ));
          }
        } else {
          navigate_push(context: context, next_Screen: const GetInfoScreen());
          print('User document not found');
        }
      });
    }).onError((error, stackTrace) {
      setSignInLoad(false);
      print(error);
      if (error.toString().contains(
          "The password is invalid or the user does not have a password.")) {
        UtilsNotify.flushBarErrorMessage("Invalid password", context);
      } else if (error.toString().contains("The user may have been deleted.")) {
        UtilsNotify.flushBarErrorMessage(
            "Please check email and password.", context);
      } else {
        print(error);
        UtilsNotify.flushBarErrorMessage("Something wrong", context);
      }
    });
  }


  bool signUpLoad = false;

  setSignUpLoad(bool setLoad) {
    signUpLoad = setLoad;
    notifyListeners();
  }

  signUp(
      {required BuildContext context,
      TextEditingController? email,
      pass}) async {
    setSignUpLoad(true);
    await auth
        .createUserWithEmailAndPassword(email: email!.text, password: pass.text)
        .then((value) {
      setSignUpLoad(false);
      navigate_push(
          context: context,
          next_Screen: GetInfoScreen(
            email: value.user!.email,
          ));
    }).onError((error, stackTrace) {
      setSignUpLoad(false);
      if (error.toString().contains(
          "The email address is already in use by another account.")) {
        UtilsNotify.flushBarErrorMessage(
            "This email is already in used", context);
      }
      print(error);
    });
  }

  bool googleloading = false;

  setGoogleLoading(bool loading) {
    googleloading = loading;
  }

  signInWithGoogle() async {
    setGoogleLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setGoogleLoading(false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        setGoogleLoading(false);
        print('User signed in: ${user.displayName}');
      }
      return user;
    } catch (e) {
      setGoogleLoading(false);
      print('Google Sign-In error: $e');
    }
  }
}
