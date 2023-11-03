import 'package:healthtick/views/counterScreen/counterScreen.dart';
import 'package:get/get.dart';

class splashScreenController extends GetxController {
  @override
  void onInit() {
    splashCounter();
    super.onInit();
  }

  splashCounter() async {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAll(() => const counterScreen()),
    );
  }
}
