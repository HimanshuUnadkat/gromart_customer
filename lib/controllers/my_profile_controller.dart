import 'package:customer/utils/preferences.dart';
import 'package:get/get.dart';

class MyProfileController extends GetxController{

  RxBool isLoading = true.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    getThem();
    super.onInit();
  }

  RxString isDarkMode = "Light".obs;
  RxBool isDarkModeSwitch = false.obs;

  getThem() {
    isDarkMode.value = Preferences.getString(Preferences.themKey);
    if (isDarkMode.value == "Dark") {
      isDarkModeSwitch.value = true;
    } else if (isDarkMode.value == "Light") {
      isDarkModeSwitch.value = false;
    } else {
      isDarkModeSwitch.value = false;
    }
    isLoading.value = false;
  }

}