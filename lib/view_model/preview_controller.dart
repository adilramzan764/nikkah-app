import 'package:get/get.dart';

class UserPreviewController extends GetxController {
  late Map<String, dynamic> userData;

  @override
  void onInit() {
    super.onInit();
    userData = Get.arguments as Map<String, dynamic>;
  }
}