import 'package:get/get.dart';
import '../model/free_tonight_model.dart';

class FreeTonightController extends GetxController {
  late RxInt currentIndex = 0.obs;
  final RxList<FreeTonightModel> mensaUsers = <FreeTonightModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMensaUsers();
  }

  void loadMensaUsers() {
    // Simulating API data for MENSA users
    final List<FreeTonightModel> users = [
      FreeTonightModel(
        age: 23,
        distance: 3.5,
        name: "Galina Fisher",
        location: "Manhattan, NY",
        image: "assets/home-image.png",
        profession: "Software Engineer",
      ),
      FreeTonightModel(
        age: 31,
        distance: 5.2,
        name: "Sarah Chen",
        location: "Brooklyn, NY",
        profession: "Data Science",
        image: "assets/home-image.png",
      ),
      FreeTonightModel(
        age: 26,
        distance: 2.8,
        name: "Maya Patel",
        profession: "AI Researcher",
        location: "Jersey City, NJ",
        image: "assets/my-vibes-imgOne.png",
      ),
      FreeTonightModel(
        age: 31,
        distance: 5.2,
        name: "Sarah Chen",
        location: "Brooklyn, NY",
        image: "assets/home-image.png",
        profession: "Software Engineer",
      ),
    ];

    mensaUsers.assignAll(users);
  }

  FreeTonightModel get currentUser => mensaUsers[currentIndex.value];

  void nextUser() {
    if (currentIndex < mensaUsers.length - 1) {
      currentIndex++;
    }
  }

  void previousUser() {
    if (currentIndex > 0) {
      currentIndex--;
    }
  }

  double getProgressValue() {
    return (currentIndex.value + 1) / mensaUsers.length;
  }

  // Getter for active step
  bool get isActiveStep => currentIndex.value == 0;
}