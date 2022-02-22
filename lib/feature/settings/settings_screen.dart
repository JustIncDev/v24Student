import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/feature/settings/bloc/settings_bloc.dart';
import 'package:v24_student_app/feature/settings/widgets/settings_screen_body.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/res/colors.dart';
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
            const Scaffold(
              backgroundColor: AppColors.white,
              body: SettingsScreenBody(),
            ),
            // state.status == BaseScreenStatus.lock ? const ProgressWall() : const Offstage(),
          ],
        );
      },
    );
  }
}
