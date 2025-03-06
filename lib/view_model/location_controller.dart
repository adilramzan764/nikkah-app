import 'package:get/get.dart';
import '../routes/routes_name.dart';

class LocationController extends GetxController {
  final isLocationSet = false.obs;

  void setLocationServices() {
    isLocationSet.value = true;
    Get.toNamed(RoutesName.countryScreen,arguments: {'isSignUp': true});
  }
}