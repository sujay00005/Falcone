import 'package:finding_flacone/import.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultController>(
      init: ResultController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.kPrimaryColor,
            body: SingleChildScrollView(
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
                          onPressed: () {
                            Get.offAll(const HomeView());
                          },
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
                          onPressed: () {
                            Get.offAll(const HomeView());
                          },
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
                    Text(
                      controller.successText == "success"
                          ? controller.successText
                          : controller.failureText,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 21,
                      ),
                    ),
                    const SizedBox(height: 35),
                    if (controller.successText == "success")
                      Text(
                        'Time taken:${controller.totalTime}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 21,
                        ),
                      ),
                    if (controller.successText == "success")
                      const SizedBox(height: 35),
                    if (controller.successText == "success")
                      Text(
                        'Planet found: ${controller.foundOnPlanet}',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 21,
                        ),
                      ),
                    if (controller.successText == "success")
                      const SizedBox(height: 35),

                    const SizedBox(
                        height: 110), // Review if this large space is necessary
                    ElevatedButton(
                      onPressed: () {
                        Get.offAll(const HomeView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Start Again',
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
}
