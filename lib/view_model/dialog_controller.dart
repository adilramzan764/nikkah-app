import 'package:get/get.dart';

class WelcomeDialogViewModel extends GetxController {
  final RxString _title;
  final RxString _message;
  final RxString _iconName;

  WelcomeDialogViewModel({
    required String title,
    required String message,
    String iconName = "beenhere",
  })  : _title = title.obs, _message = message.obs, _iconName = iconName.obs;

  String get title => _title.value;

  String get message => _message.value;

  String get iconName => _iconName.value;
}