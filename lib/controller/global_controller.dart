import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxDouble lattittude = 0.0.obs;
  final RxDouble longittude = 0.0.obs;
  RxBool checkLoading() => isLoading;
  RxDouble getLattittude() => lattittude;
  RxDouble getLongittude() => longittude;

  @override
  void onInit() {
    if (isLoading.isTrue) {
      getLocation();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("location not enabled");
    }
    // status of Permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request Premission
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location premission is denied');
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      lattittude.value = value.latitude;
      longittude.value = value.longitude;
      isLoading.value = false;

    });
  }
}
