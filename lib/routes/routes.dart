import 'package:nikkah_app/view_model/edit_profile_controller.dart';

import '../view/SignUp/AddPhotosScreen.dart';
import '../view/SignUp/religion_screen.dart';
import '../view_model/AddPhotos_Conrtoller.dart';
import 'routes_name.dart';
import 'package:get/get.dart';
import '../view/SignUp/country_screen.dart';
import '../view/SignUp/sign_up_screen.dart';
import '../res/binding/binding_class.dart';
import '../view_model/dob_controller.dart';
import '../view_model/drink_controller.dart';
import '../view_model/gender_controller.dart';
import '../view_model/height_controller.dart';
import '../view_model/country_controller.dart';
import '../view_model/job_title_controller.dart';
import '../view_model/star_sign_controller.dart';
import '../view_model/education_controller.dart';
import '../view_model/intentions_controller.dart';
import 'package:nikkah_app/view/SignUp/drink_screen.dart';
import '../view_model/description_controller.dart';
import '../view_model/personality_controller.dart';
import 'package:nikkah_app/view/SignUp/gender_screen.dart';
import 'package:nikkah_app/view/SignUp/height_screen.dart';
import 'package:nikkah_app/view/LogIn/SignIn_Screen.dart';
import 'package:nikkah_app/view/SignUp/workout_screen.dart';
import 'package:nikkah_app/view/OnboardingScreens/login_a_screen.dart';
import 'package:nikkah_app/model/location_model.dart';
import 'package:nikkah_app/view/SignUp/interest_screen.dart';
import 'package:nikkah_app/view/SignUp/job_tile_screen.dart';
import 'package:nikkah_app/view/SignUp/language_screen.dart';
import 'package:nikkah_app/view/SignUp/location_screen.dart';
import 'package:nikkah_app/view/SignUp/star_sign_screen.dart';
import 'package:nikkah_app/view/SignUp/community_screen.dart';
import 'package:nikkah_app/view/BottomNavBar/main_home_screen.dart';
import 'package:nikkah_app/view/SignUp/education_screen.dart';
import 'package:nikkah_app/view/SignUp/intention_screen.dart';
import 'package:nikkah_app/view/SignUpWithPhoneNumber/phone_otp_screen.dart';
import 'package:nikkah_app/view/ForgetPasswordScreens/email_code_screen.dart';
import 'package:nikkah_app/view/OnboardingScreens/onboarding_screen.dart';
import 'package:nikkah_app/view/SignUp/personality_screen.dart';
import 'package:nikkah_app/view/SignUp/description_screen.dart';
import 'package:nikkah_app/view/free_tonight_screen.dart';
import 'package:nikkah_app/view/ForgetPasswordScreens/new_password_screen.dart';
import 'package:nikkah_app/view/SignUp/date_of_birth_screen.dart';
import 'package:nikkah_app/view/SignUp/image_selection_screen.dart';
import 'package:nikkah_app/view/ForgetPasswordScreens/forget_password_screen.dart';
import 'package:nikkah_app/view/SignUpWithPhoneNumber/phone_number_auth_screen.dart';

class AppRoutes {
  static List<GetPage> appRoutes() {
    return [
      GetPage(
        name: RoutesName.onBoardingScreen,
        page: () => OnboardingScreen(),
      ),
      GetPage(
        name: RoutesName.loginAScreen,
        page: () => const LogInAScreen(),
      ),
      GetPage(
        name: RoutesName.signUpScreen,
        page: () => const SignUpScreen(),
      ),
      // GetPage(
      //   name: RoutesName.loginBScreen,
      //   page: () => const LogInBScreen(),
      //   transition: Transition.rightToLeft,
      // ),
      GetPage(
        name: RoutesName.loginCScreen,
        page: () => const LogInCScreen(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutesName.forgetPasswordScreen,
        page: () =>  ForgetPasswordScreen(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutesName.emailCodeScreen,
        page: () =>   EmailCodeScreen(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutesName.newPasswordScreen,
        page: () => const NewPasswordScreen(),
        transition: Transition.rightToLeft,

      ),
      GetPage(
        name: RoutesName.phoneNumberAuthScreen,
        page: () =>  PhoneNumberAuthScreen(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: RoutesName.phoneOtpScreen,
        page:() => PhoneOtpScreen(),
      ),
      GetPage(
        name: RoutesName.locationScreen,
        page: () =>  LocationScreen(isSignUp: Get.arguments['isSignUp']),
        binding: BindingsBuilder(() {
          Get.lazyPut<LocationViewModel>(() => LocationViewModel());
        }),
      ),
      GetPage(
        name: RoutesName.countryScreen,
        page: () =>  CountryScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed if needed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => CountryController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.religionScreen,
        page: () => ReligionScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EditProfileController());

          // Get.lazyPut<ReligionViewModel>(() => ReligionViewModel());
        }),
      ),
      GetPage(
        name: RoutesName.languageScreen,
        page: () => LanguageScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EditProfileController());

          // Get.lazyPut<LanguageViewModel>(() => LanguageViewModel());
        }),
      ),
      GetPage(
        name: RoutesName.communityScreen,
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        page: () =>  CommunityScreen(isSignUp: Get.arguments['isSignUp']),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.educationScreen,
        page: () =>  EducationScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EducationController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.dateOfBirth,
        page: () =>  DateOfBirthScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => DateOfBirthController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.genderScreen,
        page: () =>  GenderScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => GenderController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.heightScreen,
        page: () =>  HeightScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => (HeightController()));
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.drinkScreen,
        page: () =>  DrinkScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut<DrinkController>(() => DrinkController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.workoutScreen,
        page: () => WorkoutScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.starSign,
        page: () => StarSignScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(()=> StarSignController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.personalityScreen,
        page: () =>  PersonalityScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          Get.lazyPut(() => PersonalityController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.descriptionScreen,
        page: () => DescriptionScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft,
        transitionDuration: Duration(milliseconds: 300),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => DescriptionController());
          Get.lazyPut(() => EditProfileController());
        }),
      ),

      GetPage(
        name: RoutesName.interestScreen,
        page: () =>  InterestsScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder(() {
          InterestsBinding();
          Get.lazyPut(() => EditProfileController());
        }),
      ),
      GetPage(
        name: RoutesName.jobTileScreen,
        page: () =>  JobTitleScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder((){
          Get.lazyPut(()=>JobTitleController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.intentionScreen,
        page: () => IntentionsScreen(isSignUp: Get.arguments['isSignUp']),
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        binding: BindingsBuilder((){
          Get.lazyPut(()=>IntentionController());
          Get.lazyPut(() => EditProfileController());

        }),
      ),
      GetPage(
        name: RoutesName.addphotos_Screen,
        transition: Transition.rightToLeft, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        page: () =>   AddPhotos_Screen(),
        // binding: ProfileBinding(),
        binding: BindingsBuilder((){
          Get.lazyPut(()=>AddPhotos_Controller());
        }),
      ),
      GetPage(
        name: RoutesName.selectionImageScreen,
        transition: Transition.leftToRight, // Slide transition
        transitionDuration: Duration(milliseconds: 300), // Adjust speed
        page: () =>  const ImagePickerScreen(),
        // binding: ProfileBinding(),
      ),
      GetPage(
        name: RoutesName.homeScreen,
        page: () => MainHomeScreen(),
      ),
      GetPage(
        name: RoutesName.freeToNightScreen,
        page: () => FreeTonightScreen(),
      ),
      // In your route definition
      // GetPage(
      //   name: RoutesName.photoUploadScreen,
      //   page: () => PhotoUploadScreen(),
      //   binding: BindingsBuilder(() {
      //     Get.lazyPut(() => PhotoViewModel());
      //   }),
      // ),
      // GetPage(
      //   name: RoutesName.profileSummaryScreen,
      //   page: () => ProfileSummaryScreen(),
      //   binding: BindingsBuilder(() {
      //     Get.lazyPut(() => ProfileController());
      //   }),
      // ),
    ];
  }
}