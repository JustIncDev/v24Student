import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:v24_student_app/domain/survey.dart';
import 'package:v24_student_app/global/ui/image/avatar_view.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';

class SurveyItemWidget extends StatefulWidget {
  const SurveyItemWidget({
    Key? key,
    required this.item,
    this.answeredSurvey = false,
  }) : super(key: key);

  final Survey item;
  final bool answeredSurvey;

  @override
  State<SurveyItemWidget> createState() => _SurveyItemWidgetState();
}

class _SurveyItemWidgetState extends State<SurveyItemWidget> with TickerProviderStateMixin {
  CountdownTimerController? _countdownController;

  @override
  void initState() {
    super.initState();
    var safeTime = widget.item.startTime;
    if (safeTime != null) {
      _countdownController = CountdownTimerController(
        endTime: safeTime.millisecondsSinceEpoch + 86400000,
        vsync: this,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        padding: const EdgeInsets.only(
          top: 11.0,
          bottom: 11.0,
          left: 20.0,
          right: 14.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowListColor.withOpacity(0.1),
              blurRadius: 30.0,
              offset: const Offset(0, 10.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title ?? '',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 13.0,
                    letterSpacing: -0.3,
                  ).montserrat(fontWeight: AppFonts.semiBold),
                ),
                if (!widget.answeredSurvey)
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Remains ',
                          style: TextStyle(
                            color: AppColors.black.withOpacity(0.4),
                            fontSize: 11.0,
                            letterSpacing: -0.3,
                          ).montserrat(fontWeight: AppFonts.medium),
                        ),
                        CountdownTimer(
                          controller: _countdownController,
                          endTime: (widget.item.startTime?.millisecondsSinceEpoch ?? 0) + 86400000,
                          widgetBuilder: (_, CurrentRemainingTime? time) {
                            return Text(
                              '${time?.hours}:${time?.min}:${time?.sec}',
                              style: TextStyle(
                                color: AppColors.black.withOpacity(0.4),
                                fontSize: 11.0,
                                letterSpacing: -0.3,
                              ).montserrat(fontWeight: AppFonts.medium),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Row(
              children: [
                Text(
                  (widget.item.author?.firstName ?? 'Logan') +
                      ' ' +
                      (widget.item.author?.lastName ?? 'Lerman'),
                  style: TextStyle(
                    color: AppColors.black.withOpacity(0.8),
                    fontSize: 11.0,
                    letterSpacing: -0.3,
                  ).montserrat(fontWeight: AppFonts.medium),
                ),
                const HorizontalSpace(10.0),
                AvatarView.network(imageUrl: widget.item.author?.avatarUrl),
              ],
            )
          ],
        ),
      ),
    );
  }
}
