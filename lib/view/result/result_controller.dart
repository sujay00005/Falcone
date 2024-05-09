import 'package:finding_flacone/import.dart';

class ResultController extends GetxController {
  var counter = 0.obs;
  String successText =
      'Success! Congratulations on finding Falcone. King Shan is mighty pleased';
  String failureText = " Sorry! Couldn't find Falcone on the selected planets.";
  String status = "";
  String totalTime = "";
  String foundOnPlanet = "";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) status = Get.arguments[0];
    if (status == "success") {
      totalTime = Get.arguments[1];
      foundOnPlanet = Get.arguments[2];
    }
  }
}
