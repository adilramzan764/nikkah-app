import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nikkah_app/routes/routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/CustomLoader.dart';

class SignOut_Controller extends GetxController {
  Future<void> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      await FacebookAuth.instance.logOut();
      CustomLoader.stopLoading();
      Get.offAllNamed(RoutesName.loginCScreen); // Navigate to login screen after logout

    } catch (e) {
      Get.snackbar("Error", "Failed to sign out: $e");
    }
  }
}
