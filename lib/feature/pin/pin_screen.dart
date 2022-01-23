import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:v24_student_app/feature/pin/bloc/pin_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/progress/progress_wall.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/global/widgets/panel_widget.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/images.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'widgets/bounce_code_widget.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PinScreenState createState() => _PinScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    bool? enterScreen;
    if (params != null) {
      enterScreen = params['enter'] as bool;
    }
    return UiUtils.createPlatformPage(
      key: const ValueKey('pin-code'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createPinBloc(enterScreen);
        },
        child: const PinScreen(),
        lazy: false,
      ),
    );
  }
}

class _PinScreenState extends State<PinScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinBloc, PinState>(
      listenWhen: (previous, current) {
        return (previous.currentCodePosition != current.currentCodePosition) ||
            (previous.status != current.status);
      },
      listener: (context, state) {
        if (state.status == BaseScreenStatus.next) {
          RootRouter.of(context)
              ?.push(const ScreenInfo(name: ScreenName.surveys), replacement: true);
        }
        if (state.currentCodePosition == 6) {
          if (state.page == PinPage.set) {
            BlocProvider.of<PinBloc>(context).add(PinConfirmInitEvent());
          } else {
            BlocProvider.of<PinBloc>(context).add(PinPerformEvent());
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              body: Column(
                children: [
                  VerticalSpace(MediaQuery.of(context).size.height * 0.3),
                  if (state.page == PinPage.enter)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 46.0),
                      child: Image(image: AppImages.logoImageAsset),
                    ),
                  Text(
                    getStringById(
                      context,
                      _getStringId(state.page),
                    ),
                    style: const TextStyle(fontSize: 18.0, color: AppColors.black)
                        .montserrat(fontWeight: AppFonts.semiBold),
                  ),
                  const VerticalSpace(40.0),
                  CodeContainerRow(codePosition: state.currentCodePosition),
                  const Spacer(),
                  DigitPanelWidget(
                    onPanelTap: ({clear, unlock, value}) {
                      if (value != null) {
                        BlocProvider.of<PinBloc>(context).add(PinInputEvent(value));
                      }
                      if (clear != null) {
                        BlocProvider.of<PinBloc>(context).add(PinClearEvent());
                      }
                    },
                    smsCode: false,
                    unlockButton: _getUnlockButtonType(state.type),
                  ),
                ],
              ),
            ),
            state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }

  PanelButtonType _getUnlockButtonType(BiometricType? type) {
    switch (type) {
      case BiometricType.fingerprint:
        return PanelButtonType.fingerprint;
      case BiometricType.face:
        return PanelButtonType.faceId;
      default:
        return PanelButtonType.empty;
    }
  }

  StringId _getStringId(PinPage type) {
    switch (type) {
      case PinPage.enter:
        return StringId.enterYourPin;
      case PinPage.set:
        return StringId.setYourPin;
      case PinPage.confirm:
        return StringId.confirmYourPin;
    }
  }
}
