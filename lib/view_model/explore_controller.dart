import 'package:get/get.dart';
import 'package:nikkah_app/model/explore_model.dart';

class ExploreViewModel extends GetxController {
  var users = <ExploreUserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() {
    // Dummy data for users
    users.value = [
      ExploreUserModel(
        age: 23,
        name: "Galina",
        location: "12 km away",
        matchStatus: "92% Match",
        imageUrl: "assets/explore-screen-imageOne.png",
      ),
      ExploreUserModel(
        age: 27,
        name: "James",
        location: "5 km away",
        matchStatus: "85% Match",
        imageUrl: "assets/explore-screen-imageTwo.png",
      ),
      ExploreUserModel(
        age: 25,
        name: "Sophia",
        location: "20 km away",
        matchStatus: "90% Match",
        imageUrl: "assets/explore-screen-imageThree.png",
      ),
      ExploreUserModel(
        age: 29,
        name: "Alan jack",
        location: "15 km away",
        matchStatus: "85% Match",
        imageUrl: "assets/explore-screen-imageFour.png",
      ),
      ExploreUserModel(
        age: 32,
        name: "Sophia",
        location: "10 km away",
        matchStatus: "90% Match",
        imageUrl: "assets/explore-screen-imageFive.png",
      ),
      ExploreUserModel(
        age: 32,
        name: "Jack",
        location: "8 km away",
        matchStatus: "90% Match",
        imageUrl: "assets/explore-screen-imageSix.png",
      ),
    ];
  }
}