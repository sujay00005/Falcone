import 'dart:convert';

import 'package:finding_flacone/import.dart';

class HomeController extends GetxController {
  var counter = 0.obs;

  var planet1 = Planet().obs;
  var planet2 = Planet().obs;
  var planet3 = Planet().obs;
  var planet4 = Planet().obs;

  var vehicle1 = Vehicle().obs;
  var vehicle2 = Vehicle().obs;
  var vehicle3 = Vehicle().obs;
  var vehicle4 = Vehicle().obs;

  var totalTime = 0.obs;

  var isDataLoading = false.obs;

  List<Planet> planets = [];

  // RxList<Planet> planet1List = RxList<Planet>();
  // RxList<Planet> planet2List = RxList<Planet>();
  // RxList<Planet> planet3List = RxList<Planet>();
  // RxList<Planet> planet4List = RxList<Planet>();

  RxList<Vehicle> vehicles = RxList<Vehicle>();

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
      print("🤪🤪🤪🤪🤪🤪🤪");
      print(planets.length);
      // planet2List.addAll(planet1List);
      // planet3List.addAll(planet1List);
      // planet4List.addAll(planet1List);
      // print("🤪🤪🤪🤪🤪🤪🤪");
      // print(
      //     "${planet1List.length}   ${planet2List.length}  ${planet3List.length}    ${planet4List.length}");
    } catch (e) {
      print("❌❌❌❌❌");
      print("Error getting Planets $e");
    }
  }

  void decrementVehicleCount(Vehicle vehicle) {
    // Find the vehicle in the list and decrement its count
    int index = vehicles.indexOf(vehicle);
    if (index != -1 && vehicles[index].totalNo! > 0) {
      vehicles[index] = Vehicle(
        name: vehicles[index].name,
        maxDistance: vehicles[index].maxDistance,
        totalNo: vehicles[index].totalNo! - 1,
      );
      update(); // Notify listeners of the update
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
