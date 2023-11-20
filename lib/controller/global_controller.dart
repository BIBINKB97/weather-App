import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxDouble lattittude = 0.0.obs;
  final RxDouble longittude = 0.0.obs;
  RxBool checkLoading() => isLoading;
  RxDouble getLattittude() => lattittude;
  RxDouble getLongittude() => longittude;

  void onInit() {
    if (isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("location maariyappo , ellam oke aaayil,");
    }
  }
}
