import 'dart:convert';

import 'package:finding_flacone/import.dart';
import 'package:get/get.dart';

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

  RxInt totalTime = 0.obs;
  RxInt previousTime = 0.obs;

  var isDataLoading = false.obs;
  var isPosting = false.obs;

  String status = "";
  String foundOnPlanet = "";

  String? _token;

  List<Planet> planets = [];

  RxList<Vehicle> vehicles = RxList<Vehicle>();
  List vehiclesCopy = [];

  var dropDownPlanetList = <String>[].obs;
  var vehicleNumberList = [1, 2, 1, 3].obs;
  var vehicleList = <String>[].obs;

  @override
  void onInit() {
    getVehicles();
    getPlanets();
    postToken();
    super.onInit();
  }

  Future<void> getVehicles() async {
    isDataLoading.value = true;
    try {
      var data = await ApiCall().getVehicles();
      var x = jsonDecode(data.bodyString!);
      for (var i = 0; i < x.length; i++) {
        var y = Vehicle.fromJson(x[i]);
        vehicles.add(y);

        vehicleList.add(vehicles[i].name ?? "");
        vehicleNumberList.add(vehicles[i].totalNo ?? 0);
      }
      vehiclesCopy.addAll(vehicles);
    } catch (e) {
      print("❌❌❌❌❌");
      print("Error getting Vehicles $e");
    } finally {
      isDataLoading.value = false;
    }
  }

  Future<void> getPlanets() async {
    isDataLoading.value = true;

    try {
      var data = await ApiCall().getPlanets();
      var x = jsonDecode(data.bodyString!);

      for (var i = 0; i < x.length; i++) {
        planets.add(Planet.fromJson(x[i]));
        dropDownPlanetList.add(planets[i].name ?? "");
      }
    } catch (e) {
      print("❌❌❌❌❌");
      print("Error getting Planets $e");
    } finally {
      isDataLoading.value = false;
    }
  }

  void decrementVehicleCount(Vehicle vehicle, Planet planet) {
    // Find the vehicle in the list and decrement its count
    int index = vehicles.indexOf(vehicle);
    if (index != -1 && vehicles[index].totalNo! > 0) {
      vehicles[index] = Vehicle(
        name: vehicles[index].name,
        maxDistance: vehicles[index].maxDistance,
        totalNo: vehicles[index].totalNo! - 1,
        speed: vehicles[index].speed,
      );
      vehicle = vehicles[index];
      totalTime += planet.distance! ~/ vehicle.speed!;
      update(); // Notify listeners of the update
    }
  }

  void incrementVehicleCount(Vehicle vehicle, Planet planet) {
    int index = -1;
    for (int i = 0; i < vehicles.length; i++) {
      if (vehicles[i].name == vehicle.name) {
        index = i;
        break;
      }
    }

    if (index != -1 && vehicles[index].totalNo! < vehiclesCopy[index].totalNo) {
      vehicles[index] = Vehicle(
        name: vehicles[index].name,
        maxDistance: vehicles[index].maxDistance,
        totalNo: vehicles[index].totalNo! + 1,
        speed: vehicles[index].speed,
      );

      totalTime -= planet.distance! ~/ vehicle.speed!;
      update(); // Notify listeners of the update
    }
  }

  Future<void> postToken() async {
    isPosting.value = true;

    try {
      var data = await ApiCall().postToken();

      _token = jsonDecode(data.bodyString!)['token'];
      print(_token);
    } catch (e) {
      print("❌❌❌❌❌");
      print("Error posting for the token $e");
    } finally {
      isDataLoading.value = false;
    }
  }

  Future<void> postFindingFalcone() async {
    isPosting.value = true;
    // print("👑");
    // print(
    //     "${planet1.value.name} ${planet2.value.name} ${planet3.value.name} ${planet4.value.name}");
    // print(
    //     "${vehicle1.value.name} ${vehicle2.value.name} ${vehicle3.value.name} ${vehicle4.value.name}");
    // print(_token);

    var postData = {
      "token": "$_token",
      "planet_names": [
        "${planet1.value.name}",
        "${planet2.value.name}",
        "${planet3.value.name}",
        "${planet4.value.name}"
      ],
      "vehicle_names": [
        "${vehicle1.value.name}",
        "${vehicle2.value.name}",
        "${vehicle3.value.name}",
        "${vehicle4.value.name}"
      ]
    };

    try {
      var data = await ApiCall().postFindFalcone(postData);

      var parsedData = jsonDecode(data.bodyString!);
      status = parsedData['status'];

      if (status == "success") {
        foundOnPlanet = parsedData['planet_name'];
      } else {
        ///Not found on the selected planets
        print("❌ ${parsedData['status']}");
      }

      // Navigator.of(Get.context!)
      //     .push(MaterialPageRoute(builder: (context) => const ResultView()));
    } catch (e) {
      print("❌❌❌❌❌❌");
      print("Error posting for Finding the Falcone $e");
    }
  }
}
