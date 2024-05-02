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

  RxList<Vehicle> vehicles = RxList<Vehicle>();
  List vehiclesCopy = [];

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
      print(vehiclesCopy);
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
      vehicle = vehicles[index];
      update(); // Notify listeners of the update
    }
  }

  void incrementVehicleCount(Vehicle vehicle) {
    // Find the vehicle in the list and decrement its count
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
      );
      update(); // Notify listeners of the update
    }
  }
}
