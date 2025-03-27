import 'dart:developer';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nikkah_app/view_model/SigninContoller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nikkah_app/view/BottomNavBar/main_home_screen.dart';
import 'package:nikkah_app/view_model/SignIN_Controller.dart';

import 'firebase_options.dart';
import 'package:nikkah_app/routes/routes.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import 'package:nikkah_app/view_model/authentication_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('6Lc5IOcqAAAAAKd7yuIfioIezlOULxaYkSuRwdoc'),
      androidProvider: AndroidProvider.safetyNet,
    );

    log("Firebase and App Check initialized successfully.");
  } catch (e) {
    log("Error initializing Firebase: $e");
  }

  Get.lazyPut(() => AuthenticationRepository());
  Get.lazyPut(() => SignInController());
  configLoading();

  bool isLoggedIn = await checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.orange
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        initialRoute: isLoggedIn ? RoutesName.homeScreen : RoutesName.onBoardingScreen,
        getPages: AppRoutes.appRoutes(),
        builder: (context, child) {
          return EasyLoading.init()(context, child);
        },
      ),
    );
  }
}
