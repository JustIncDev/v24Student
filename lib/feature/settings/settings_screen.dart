import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:v24_student_app/feature/settings/bloc/settings_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('settings'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createSettingsBloc();
        },
        child: const SettingsScreen(),
        lazy: false,
      ),
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listenWhen: (previous, current) {
        // return (previous.needFocusField != current.needFocusField) ||
        //     (previous.status != current.status && current.status == BaseScreenStatus.next);
        return false;
      },
      listener: (context, state) {},
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.white,
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: SafeArea(
                          top: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const VerticalSpace(58.5),
                                Center(
                                  child: Text(
                                    getStringById(context, StringId.settings),
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                const VerticalSpace(24.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getStringById(context, StringId.notificationsEnabled),
                                      style: const TextStyle(
                                        color: AppColors.royalBlue,
                                        fontSize: 13.0,
                                        letterSpacing: -0.3,
                                      ).montserrat(fontWeight: AppFonts.semiBold),
                                    ),
                                    FlutterSwitch(
                                      width: 44.0,
                                      height: 24.0,
                                      value: true,
                                      padding: 3.0,
                                      onToggle: (value) {},
                                      activeColor: AppColors.royalBlue,
                                      toggleSize: 18.0,
                                    ),
                                  ],
                                ),
                                const VerticalSpace(18.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getStringById(context, StringId.darkMode),
                                      style: const TextStyle(
                                        color: AppColors.royalBlue,
                                        fontSize: 13.0,
                                        letterSpacing: -0.3,
                                      ).montserrat(fontWeight: AppFonts.semiBold),
                                    ),
                                    FlutterSwitch(
                                      width: 44.0,
                                      height: 24.0,
                                      padding: 3.0,
                                      toggleSize: 18.0,
                                      value: false,
                                      onToggle: (value) {},
                                      activeColor: AppColors.royalBlue,
                                    ),
                                  ],
                                ),
                                const VerticalSpace(18.0),
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    getStringById(context, StringId.privacyPolicy),
                                    style: const TextStyle(
                                      color: AppColors.linkColor,
                                      fontSize: 13.0,
                                      letterSpacing: -0.3,
                                      decoration: TextDecoration.underline,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minimumSize: Size.zero,
                                  ),
                                ),
                                const VerticalSpace(18.0),
                                TextButton(
                                  onPressed: null,
                                  child: Text(
                                    getStringById(context, StringId.termsOfUse),
                                    style: const TextStyle(
                                      color: AppColors.linkColor,
                                      fontSize: 13.0,
                                      letterSpacing: -0.3,
                                      decoration: TextDecoration.underline,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft,
                                    minimumSize: Size.zero,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }
}
