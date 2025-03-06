import 'package:get/get.dart';

class PhoneNumberController extends GetxController {
  RxString phoneNumber = ''.obs;
  RxString selectedCountryCode = ''.obs;

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  void updatePhoneNumber(String number) {
    phoneNumber.value = number;
  }
}