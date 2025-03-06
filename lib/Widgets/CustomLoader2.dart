import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomLoader2 {
  static Future<void> startLoading({required String loadingStatus}) async {

    await showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 150,
              child: AlertDialog(
                shadowColor: Colors.black45,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Smaller border radius
                ),
                contentPadding: EdgeInsets.zero,
                content: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple, Colors.blue],
                    ).createShader(bounds);
                  },
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
  });

  }

  static Future<void> stopLoading() async {
    if (Navigator.of(Get.context!).canPop()) {
      Navigator.of(Get.context!).pop();
    }  }

}
