import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomLoader {
  static Future<void> startLoading({required String loadingStatus}) async {
    await EasyLoading.show(
      status: loadingStatus,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static Future<void> stopLoading() async {
    await EasyLoading.dismiss();
  }
}
