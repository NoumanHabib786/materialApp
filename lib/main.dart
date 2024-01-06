import 'package:material_app/Providers/auth_Provider.dart';
import 'package:material_app/Providers/functions.dart';
import 'package:material_app/Providers/userProvider.dart';
import 'package:material_app/Styles/colors.dart';
import 'package:material_app/Screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'Providers/toolsProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      DevicePreview(
    enabled: false,
    tools: const [...DevicePreview.defaultTools],
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Functions_Provider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),ChangeNotifierProvider(
            create: (context) => ToolsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),

        ],
        child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: mainBlack,
          ),
          home: const SplashScreen(),
        ),
      );
    });
  }
}
