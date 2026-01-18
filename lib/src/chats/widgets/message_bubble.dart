// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hicoach_coach/core/constants/colors.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isMe,
    required this.message,
    required this.time,
  });

  final bool isMe;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IntrinsicWidth(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      decoration: BoxDecoration(
                        color: isMe
                            ? AppColors.primary.withValues(alpha: .8)
                            : const Color(0xffF0F4F9),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  message,
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .copyWith(fontWeight: FontWeight.normal),
                                ),
                              ),
                              if (message.length < 20) ...[
                                const SizedBox(width: 10),
                                Padding(
                                  padding:  EdgeInsets.only(top: 8.h),
                                  child: Text(
                                    time,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 10.sp,
                                          color: Colors.grey.shade800,
                                        ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (message.length >= 20) ...[
                            const SizedBox(height: 5),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade800,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
