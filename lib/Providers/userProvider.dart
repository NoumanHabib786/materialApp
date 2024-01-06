import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_app/Screens/UserScreens/home.dart';
import 'package:material_app/Widgets/navigators.dart';
import 'package:material_app/Widgets/utils.dart';
import 'package:provider/provider.dart';

import '../Models/response.dart';
import '../Screens/adminScreens/mainScreen.dart';

class UserProvider with ChangeNotifier {
  var firebase = FirebaseAuth.instance.currentUser;
  var auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference serviers =
      FirebaseFirestore.instance.collection('servicers');
  final CollectionReference userServices =
      FirebaseFirestore.instance.collection('userWithServices');

  final CollectionReference toolsCollection =
      FirebaseFirestore.instance.collection('tools');
  final CollectionReference addToCartCollection =
      FirebaseFirestore.instance.collection('addToCart');

  Future<void> addTools(
      {String? toolName,
      String? toolPrice,
      String? toolImage,
      String? toolDescription,
      List? toolApplication,
      List? toolSpecification,
      required BuildContext context}) async {
    Response response = Response();
    final docReference = toolsCollection.doc();
    return docReference.set({
      'id': docReference.id,
      'toolName': toolName,
      'toolPrice': toolPrice,
      'toolDescription': toolDescription,
      'toolImage': toolImage,
      'toolApplication': toolApplication,
      'toolSpecification': toolSpecification,
      'timestamp': Timestamp.now(),
    }).then((value) {
      print("object");
      response.code = 200;
    }).catchError((e) {
      response.code = 500;
      response.message = e;
      print(e);
      print("Error");
    });
  }

  Future<void> addToCart(
      {Map<String, dynamic>? tool,
      Map<String, dynamic>? user,
      String? toolId,
      String? userId,
      required BuildContext context}) async {
    Response response = Response();
    final docReference = addToCartCollection.doc();
    return docReference.set({
      'id': docReference.id,
      'userId': userId,
      'tools': tool,
      'user': user,
      'timestamp': Timestamp.now(),
    }).then((value) {
      print("object");
      response.code = 200;
    }).catchError((e) {
      response.code = 500;
      response.message = e;
      print(e);
      print("Error");
    });
  }

  Future<void> addUserService(
      {Map<String, dynamic>? serviceDetails,
      Map<String, dynamic>? userDetails,
      String? serviceId,
      String? userId,
      required BuildContext context}) async {
    Response response = Response();
    final docReference = userServices.doc(serviceId);
    return docReference.set({
      'service': serviceDetails,
      'user': userDetails,
      'id': serviceId,
      'userId': userId,
      'status': "pending",
      'timestamp': Timestamp.now(),
    }).then((value) {
      print("object");
      response.code = 200;
    }).catchError((e) {
      response.code = 500;
      response.message = e;
      print(e);
      print("Error");
    });
  }

  Future<void> addUser(
      {String? name,
      String? image,
      String? contactNumber,
      String? age,
      String? terms,
      String? email,
      required BuildContext context}) async {
    Response response = Response();
    final docReference = users.doc(firebase!.uid);
    return docReference.set({
      'id': firebase!.uid,
      'email': email,
      'name': name,
      'number': contactNumber,
      'age': age,
      'image': image,
      'terms': terms,
      'role': "user",
      'timestamp': Timestamp.now(),
    }).then((value) {
      print("object");
      response.code = 200;
      response.message = "Successfully added to the database";
      UtilsNotify.flushBarErrorMessage(response.message!, context);
      users
          .where('id', isEqualTo: firebase!.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          print(userData['role']);
          if (userData['role'] == "admin") {
            navigate_remove_untill(
                context: context, next_Screen: MainAdminScreen());
          } else {
            navigate_remove_untill(
                context: context,
                next_Screen: HomeScreen(
                  name: userData['name'],
                ));
          }
        } else {
          print('User document not found');
        }
      });
    }).catchError((e) {
      response.code = 500;
      response.message = e;
      print(e);
      print("Error");
    });
  }

  bool isServiceMan = false;

  setisServiceMan(bool isLoad) {
    isServiceMan = isLoad;
    notifyListeners();
  }

  String? serviceImage;
  String? serviceName;
  String? serviceEmail;
  bool isServiceLoading = false;

  setLoadingSerive(bool load) {
    isServiceLoading = load;
    notifyListeners();
  }

  getServiceInformation(BuildContext context, String id) {
    setLoadingSerive(true);
    serviers
        .where('id', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        print(userData['role']);
        serviceImage = userData['image'];
        serviceName = userData['name'];
        serviceEmail = userData['email'];
        setLoadingSerive(false);
      } else {
        setLoadingSerive(false);

        print('User document not found');
      }
    });
    notifyListeners();
  }

  Future<String> addServiceMan(
      {String? email,
      String? password,
      String? name,
      File? image,
      String? contactNumber,
      String? experience,
      String? location,
      String? age,
      String? whichType,
      required BuildContext context}) async {
    setisServiceMan(true);
    Response response = Response();

    var message = await auth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print("User created successfully");
      var isSuccess = postFileMessage(image!.path, context).then((imageValue) {
        final docReference = serviers.doc(value.user!.uid);
        var docReferenceUser = users.doc(value.user!.uid);
        var isadded = docReference.set({
          'id': value.user!.uid,
          'email': email,
          'password': password,
          'name': name,
          'number': contactNumber,
          'experience': experience,
          'location': location,
          'age': age,
          'image': imageValue,
          'type': whichType,
          'role': "Service",
          'request': "pending",
          'user': null,
          'timestamp': Timestamp.now(),
        }).then((value2) {
          print("Added");
          docReferenceUser.set({
            'id': value.user!.uid,
            'email': email,
            'name': name,
            'number': contactNumber,
            'age': age,
            'image': imageValue,
            'terms': "true",
            'role': "Service",
            'timestamp': Timestamp.now(),
          }).then((value) {
            response.code = 200;
            response.message = "Successfully added";
            UtilsNotify.flushBarErrorMessage(response.message!, context);
            setisServiceMan(false);
          });

          return "added";
        }).catchError((e) {
          response.code = 500;
          response.message = e;
          print(e);
          print("Error");
          setisServiceMan(false);
          return "addedError";
        });
        return isadded;
      }).onError((error, stackTrace) {
        UtilsNotify.flushBarErrorMessage("Something wrong", context);
        setisServiceMan(false);
        return "imageError";
      });
      return isSuccess;
    }).onError((error, stackTrace) {
      if (error.toString().contains(
          "The email address is already in use by another account.")) {
        UtilsNotify.flushBarErrorMessage(
            "This email is already in used", context);
        setisServiceMan(false);
      }

      return "emailError$error";
    });
    return message;
  }

  Future<String?> postFileMessage(String post, BuildContext context) async {
    try {
      final path = 'usersFile/${post.split('/').last.split(".").first}';
      log(path);
      final ref = FirebaseStorage.instance.ref().child(path);
      log(ref.toString());
      UploadTask putFile = ref.putFile(File(post));
      putFile.asStream().listen((event) {
        log(event.totalBytes.toString());
        log(event.bytesTransferred.toString());
      });
      final snapshot = await putFile.whenComplete(() {});
      final url = snapshot.ref.getDownloadURL();
      log(url.toString());
      return url;
    } catch (e) {
      UtilsNotify.flushBarErrorMessage("$e", context);
      throw e;
    }
  }

//  Stream<DocumentSnapshot> readEmployee(String id) {
//   CollectionReference notesItemCollection = FirebaseFirestore.instance.collection('user');
//   return notesItemCollection.doc();
// }
}
