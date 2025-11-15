import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/error/app_error_widget.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/src/navbar/views/tabs.dart';
import 'package:hicoach_coach/src/profile/controller/profile_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

class BottomNavbarView extends StatefulWidget {
  const BottomNavbarView({super.key});

  @override
  State<BottomNavbarView> createState() => _BottomNavbarViewState();
}

class _BottomNavbarViewState extends State<BottomNavbarView> {
  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.fetchCurrentUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: LoadingOverlay(
          isLoading: controller.profileLoading.value,
          color: Colors.transparent,
          progressIndicator: circularProgress(context),
          child: controller.profileLoading.value
              ? const SizedBox.shrink()
              : controller.user != null
              ? const CoachTabs()
              : controller.errorFetchingData.value == false
              ? const SizedBox.shrink()
              : AppErrorWidget(
                  onRetry: () {
                    controller.fetchCurrentUser();
                  },
                ),
        ),
      ),
    );
  }
}
