import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hicoach_coach/common/dialogs/error_dialog.dart';
import 'package:hicoach_coach/common/headings/heading.dart';
import 'package:hicoach_coach/common/indicators/progress_indicators.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:hicoach_coach/core/constants/strings.dart';
import 'package:hicoach_coach/src/authentication/controllers/signup_controller.dart';
import 'package:hicoach_coach/src/authentication/widget/auth_button.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CoachingProfileSetup extends StatefulWidget {
  const CoachingProfileSetup({super.key});

  @override
  State<CoachingProfileSetup> createState() => _CoachingProfileSetupState();
}

class _CoachingProfileSetupState extends State<CoachingProfileSetup> {
  final List<TextEditingController> _playingControllers = [];
  final List<TextEditingController> _coachingControllers = [];
  final TextEditingController _bio = TextEditingController();
  final List<FocusNode> _playingFocusNodes = [];
  final List<FocusNode> _coachingFocusNodes = [];

  @override
  void initState() {
    super.initState();
    _addNewPlayingKeyPoint();
    _addNewCoachingKeyPoint();
  }

  void _addNewPlayingKeyPoint() {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    controller.addListener(() {});

    focusNode.addListener(() {
      if (focusNode.hasFocus &&
          controller.text.isEmpty &&
          _playingFocusNodes.length > 1) {
        if (_playingFocusNodes[_playingFocusNodes.length - 2] == focusNode) {
          _removePlayingKeyPoint(_playingFocusNodes.length - 1);
        }
      }
    });

    setState(() {
      _playingControllers.add(controller);
      _playingFocusNodes.add(focusNode);
    });
  }

  void _removePlayingKeyPoint(int index) {
    if (index != 0) {
      setState(() {
        _playingControllers[index].dispose();
        _playingFocusNodes[index].dispose();
        _playingControllers.removeAt(index);
        _playingFocusNodes.removeAt(index);
      });
    }
  }

  void _addNewCoachingKeyPoint() {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    controller.addListener(() {});

    focusNode.addListener(() {
      if (focusNode.hasFocus &&
          controller.text.isEmpty &&
          _coachingFocusNodes.length > 1) {
        if (_coachingFocusNodes[_coachingFocusNodes.length - 2] == focusNode) {
          _removeCoachingKeyPoint(_coachingFocusNodes.length - 1);
        }
      }
    });

    setState(() {
      _coachingControllers.add(controller);
      _coachingFocusNodes.add(focusNode);
    });
  }

  void _removeCoachingKeyPoint(int index) {
    if (index != 0) {
      setState(() {
        _coachingControllers[index].dispose();
        _coachingFocusNodes[index].dispose();
        _coachingControllers.removeAt(index);
        _coachingFocusNodes.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    _coachingControllers.map((controller) => controller.dispose());
    _playingControllers.map((controller) => controller.dispose());
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: Obx(
        () => LoadingOverlay(
          isLoading: controller.updatingInfo.value,
          progressIndicator: circularProgress(context),
          color: Colors.black12,

          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  TitleSubtitle(
                    padding: EdgeInsets.zero,
                    title: 'Your Profile',
                  ),
                  SizedBox(height: 10.h),
                  Text('Bio', style: Theme.of(context).textTheme.titleSmall!),
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColors.filled,
                    ),
                    child: TextField(
                      maxLines: null,
                      maxLength: null,
                      controller: _bio,
                      decoration: const InputDecoration(
                        hintText:
                            'Tell us about yourself and your teaching style...',
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Playing Experience',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  ..._playingControllers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final controller = entry.value;
                    final focusNode = _playingFocusNodes[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: Theme.of(context).textTheme.titleSmall!,
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onSubmitted: (text) {
                                if (text.isNotEmpty &&
                                    index == _playingControllers.length - 1) {
                                  _addNewPlayingKeyPoint();
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(_playingFocusNodes.last);
                                }
                              },
                              decoration: InputDecoration(
                                hintText:
                                    'Tell us about your accolades as a player...',
                                suffixIcon: index == 0
                                    ? null
                                    : IconButton(
                                        onPressed: () {
                                          _removePlayingKeyPoint(index);
                                        },
                                        icon: const Icon(Icons.close, size: 15),
                                      ),
                                disabledBorder: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(),
                                errorBorder: const UnderlineInputBorder(),
                                focusedBorder: const UnderlineInputBorder(),
                                border: const UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 30.h),
                  Text(
                    'Coaching Experience',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  ..._coachingControllers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final controller = entry.value;
                    final focusNode = _coachingFocusNodes[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: Theme.of(context).textTheme.titleSmall!,
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onSubmitted: (text) {
                                if (text.isNotEmpty &&
                                    index == _coachingControllers.length - 1) {
                                  _addNewCoachingKeyPoint();
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(_coachingFocusNodes.last);
                                }
                              },
                              decoration: InputDecoration(
                                hintText:
                                    'Tell us about your coaching experience...',
                                suffixIcon: index == 0
                                    ? null
                                    : IconButton(
                                        onPressed: () {
                                          _removeCoachingKeyPoint(index);
                                        },
                                        icon: const Icon(Icons.close, size: 15),
                                      ),
                                disabledBorder: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(),
                                errorBorder: const UnderlineInputBorder(),
                                focusedBorder: const UnderlineInputBorder(),
                                border: const UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 40.h),
                  Text(
                    'Certifications',
                    style: Theme.of(context).textTheme.titleSmall!,
                  ),
                  SizedBox(height: 10.h),
                  Stack(
                    children: [
                      Container(
                        height: 85.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                        ),
                        child: controller.certificaiton.value != null
                            ? Image(
                                image: FileImage(
                                  File(controller.certificaiton.value!.path),
                                ),
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: IconButton(
                                  onPressed: () {
                                    controller.pickCertificate();
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                      ),
                      if (controller.certificaiton.value != null)
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: IconButton(
                            onPressed: () {
                              controller.certificaiton.value = null;
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: AuthButton(
                      label: 'Save',
                      onPressed: () {
                        String playingExperience = _playingControllers
                            .map((controller) => controller.text)
                            .join('\n');
                        String coachingExperience = _coachingControllers
                            .map((controller) => controller.text)
                            .join('\n');
                        if (_bio.text.isNotEmpty &&
                            playingExperience.isNotEmpty &&
                            coachingExperience.isNotEmpty) {
                          controller.bio.value = _bio.text;
                          controller.coachingExperience.value =
                              coachingExperience;
                          controller.playingExperience.value =
                              playingExperience;
                          controller.saveCoach();
                        } else {
                          showErrorDialog("All fields are required");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
