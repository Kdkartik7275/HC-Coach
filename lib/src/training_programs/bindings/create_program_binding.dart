import 'package:get/get.dart';
import 'package:hicoach_coach/src/training_programs/controller/create_training_program_controller.dart';

class CreateTrainingProgramBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateTrainingProgramController>(
      () => CreateTrainingProgramController(),
    );
  }
}
