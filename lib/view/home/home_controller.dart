import 'dart:convert';

import 'package:finding_flacone/import.dart';

class HomeController extends GetxController {
  var counter = 0.obs;

  var planet1 = "".obs;
  var planet2 = "".obs;
  var planet3 = "".obs;
  var planet4 = "".obs;

  var vehicle1 = "".obs;
  var vehicle2 = "".obs;
  var vehicle3 = "".obs;
  var vehicle4 = "".obs;

  var totalTime = 0.obs;

  var isDataLoading = false.obs;

  List<Planet> planets = <Planet>[];
  List<Vehicle> vehicles = <Vehicle>[];

  var dropDownPlanetList = <String>[].obs;
  var vehicleNumberList = [1, 2, 1, 3].obs;
  var vehicleList = <String>[].obs;

  @override
  void onInit() {
    getVehicles();
    getPlanets();
    super.onInit();
  }

  Future<void> getVehicles() async {
    print("🌈🌈🌈🌈🌈🌈🌈🌈🌈");

    try {
      var data = await ApiCall().getVehicles();
      var x = jsonDecode(data.bodyString!);
      for (var i = 0; i < x.length; i++) {
        var y = Vehicle.fromJson(x[i]);
        vehicles.add(y);

        vehicleList.add(vehicles[i].name ?? "");
        vehicleNumberList.add(vehicles[i].totalNo ?? 0);
      }
      print(vehicles);
    } catch (e) {
      print("❌❌❌❌❌");
      print("Error getting Vehicles $e");
    }
  }

  Future<void> getPlanets() async {
    print("🤪🤪🤪🤪🤪🤪🤪");

    try {
      var data = await ApiCall().getPlanets();
      var x = jsonDecode(data.bodyString!);

      for (var i = 0; i < x.length; i++) {
        planets.add(Planet.fromJson(x[i]));
        dropDownPlanetList.add(planets[i].name ?? "");
      }
      print(planets);
    } catch (e) {
      print("❌❌❌❌❌");
      print("Error getting Planets $e");
    }
  }

  // void getPlanets() async {
  //   isDataLoading.value = true;
  //
  //   print("🌈");
  //   print("🌈");
  //   print("🌈");
  //   print("🌈");
  //
  //   _apiHelper.getVehicles().futureValue((value) {
  //     print("😆😆");
  //     print(value.toString());
  //     print(value);
  //     var data = SpaceCraft.fromJson(value);
  //   }, onError: (error) {
  //     if (kDebugMode) {
  //       print("Get 😆😆😆😆😆😆😆😆😆😆 $error");
  //     }
  //   });
  //   try {
  //     _apiHelper.getPlanets().futureValue((value) {
  //       print("😆😆😆😆");
  //       print(value);
  //       print(value.toString());
  //
  //       // planets = Planet.fromJson(json)
  //     }, onError: (error) {
  //       if (kDebugMode) {
  //         print("Get Shows $error");
  //       }
  //     });
  //     // print("🌈🌈🌈🌈🌈");
  //     // var value = await _apiHelper.getPlanets();
  //     // print("😆😆😆😆");
  //     // print(value.toString());
  //     //
  //     // // value.forEach((v) {
  //     // //   planets.add(Planet.fromJson(v));
  //     // // });
  //     //
  //     // print("😆😆😆😆😆😆😆😆😆");
  //     // print(planets);
  //     // print(planets[0].name);
  //     //
  //     // isDataLoading.value = false;
  //   } catch (error) {
  //     print("XXXXXX");
  //     isDataLoading.value = false;
  //     if (kDebugMode) {
  //       print("Get Planet Data $error");
  //     }
  //   }
  // }
}
