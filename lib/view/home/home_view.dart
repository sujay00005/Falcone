import 'package:finding_flacone/import.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        // Filter planets for each destination dropdown
        List<Planet> planets1 = controller.planets
            .where((item) =>
                item != controller.planet2.value &&
                item != controller.planet3.value &&
                item != controller.planet4.value)
            .toList();
        List<Planet> planets2 = controller.planets
            .where((item) =>
                item != controller.planet1.value &&
                item != controller.planet3.value &&
                item != controller.planet4.value)
            .toList();
        List<Planet> planets3 = controller.planets
            .where((item) =>
                item != controller.planet1.value &&
                item != controller.planet2.value &&
                item != controller.planet4.value)
            .toList();
        List<Planet> planets4 = controller.planets
            .where((item) =>
                item != controller.planet1.value &&
                item != controller.planet2.value &&
                item != controller.planet3.value)
            .toList();

        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.kPrimaryColor,
            body: SingleChildScrollView(
              // Allows the column to be scrollable
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: AppColors.white),
                          ),
                          onPressed: () {},
                        ),
                        const Text(
                          ' | ',
                          style: TextStyle(color: AppColors.white),
                        ),
                        TextButton(
                          child: const Text(
                            'GeekTrust Home',
                            style: TextStyle(color: AppColors.white),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Text(
                      'Finding Falcone!',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 35,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Select planets you want to search in:',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 21,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        planetAndVehicle(controller, planets1, "Destination 1",
                            controller.planet1, controller.vehicle1),
                        planetAndVehicle(controller, planets2, "Destination 2",
                            controller.planet2, controller.vehicle2),
                        planetAndVehicle(controller, planets3, "Destination 3",
                            controller.planet3, controller.vehicle3),
                        planetAndVehicle(controller, planets4, "Destination 4",
                            controller.planet4, controller.vehicle4),
                        Text(
                          'Total time: ${controller.totalTime}',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),

                    //   [
                    //     planetAndVehicle(controller, planets1, "Destination 1",
                    //         controller.planet1, controller.vehicle1),
                    //     planetAndVehicle(controller, planets2, "Destination 2",
                    //         controller.planet2, controller.vehicle2),
                    //     planetAndVehicle(controller, planets3, "Destination 3",
                    //         controller.planet3, controller.vehicle3),
                    //     planetAndVehicle(controller, planets4, "Destination 4",
                    //         controller.planet4, controller.vehicle4),
                    //     Text(
                    //       'Total time: ${controller.totalTime}',
                    //       style: const TextStyle(
                    //         color: AppColors.white,
                    //         fontSize: 25,
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    const SizedBox(
                        height: 110), // Review if this large space is necessary
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Find Falcone!',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Coding problem - www.findingfalcone',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Column planetAndVehicle(
    HomeController controller,
    List<Planet> planetList,
    String destination,
    Rx<Planet> planet,
    Rx<Vehicle> vehicle,
  ) {
    return Column(
      children: [
        PillDropdownButton(
          width: 130,
          dropDownList: planetList,
          onSelectionChanged: (Planet changedPlanet) {
            planet.value = changedPlanet;
            controller.update(); // Refresh UI when planet changes
          },
          destination: destination,
        ),
        const SizedBox(height: 30),
        Obx(() => Visibility(
              visible: planet.value.name != null, // Ensure a planet is selected
              child: SizedBox(
                height: 200,
                width: 220,
                child: ListView(
                  shrinkWrap: true,
                  children: controller.vehicles.map((spaceCraft) {
                    bool isDisabled = (planet.value.distance ?? 0) >
                        (spaceCraft.maxDistance ?? 0);
                    return RadioListTile<Vehicle>(
                      title: Text(
                        '${spaceCraft.name} (${spaceCraft.totalNo})',
                        style: TextStyle(
                            color:
                                isDisabled ? AppColors.grey : AppColors.white),
                      ),
                      activeColor: Colors.white,
                      value: spaceCraft,
                      groupValue: vehicle.value,
                      onChanged: isDisabled
                          ? null
                          : (Vehicle? changedVehicle) {
                              if (changedVehicle != null &&
                                  changedVehicle.totalNo! > 0) {
                                vehicle.value = changedVehicle;
                                controller.decrementVehicleCount(
                                    changedVehicle); // Use the new method
                              }
                              // if (changedVehicle != null &&
                              //     changedVehicle.totalNo! > 0) {
                              //   vehicle.value = changedVehicle;
                              //   changedVehicle.totalNo--; // Decrement the count
                              //   controller
                              //       .update(); // Refresh UI when vehicle changes
                              // }
                            },
                    );
                  }).toList(),
                ),
              ),
            )),
      ],
    );
  }
}
