import 'package:finding_flacone/import.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
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
                        planetAndVehicle(controller, "Destination 1",
                            controller.planet1, controller.vehicle1),
                        planetAndVehicle(controller, "Destination 2",
                            controller.planet2, controller.vehicle2),
                        planetAndVehicle(controller, "Destination 3",
                            controller.planet3, controller.vehicle3),
                        planetAndVehicle(controller, "Destination 4",
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
    String destination,
    RxString planet,
    RxString vehicle,
  ) {
    return Column(
      children: [
        PillDropdownButton(
          width: 130,
          dropDownList: controller.dropDownPlanetList,
          onSelectionChanged: (String changedValue) {
            planet.value = changedValue;
          },
          destination: destination,
        ),
        const SizedBox(height: 30),
        Obx(
          () => Opacity(
            opacity: planet.value == "" ? 0 : 1,
            child: SizedBox(
              height: 200,
              width: 220,
              child: ListView(
                shrinkWrap: true,
                children: controller.vehicles.map((spaceCraft) {
                  return RadioListTile<String>(
                    title: Text(
                      '${spaceCraft.name} (${spaceCraft.totalNo})',
                      style: const TextStyle(color: AppColors.white),
                    ),
                    activeColor: Colors.white,
                    value: spaceCraft.name ?? "",
                    groupValue: vehicle.value,
                    onChanged: (String? newValue) {
                      vehicle.value = newValue!;
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
