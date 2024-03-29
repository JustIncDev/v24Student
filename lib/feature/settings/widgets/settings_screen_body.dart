import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                      const _SettingSwitchItem(title: StringId.notificationsEnabled),
                      const VerticalSpace(18.0),
                      const _SettingSwitchItem(title: StringId.darkMode),
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
    );
  }
}

class _SettingSwitchItem extends StatefulWidget {
  const _SettingSwitchItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final StringId title;

  @override
  State<_SettingSwitchItem> createState() => _SettingSwitchItemState();
}

class _SettingSwitchItemState extends State<_SettingSwitchItem> {
  @override
  Widget build(BuildContext context) {
    var _toggleValue = false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getStringById(context, widget.title),
          style: const TextStyle(
            color: AppColors.royalBlue,
            fontSize: 13.0,
            letterSpacing: -0.3,
          ).montserrat(fontWeight: AppFonts.semiBold),
        ),
        FlutterSwitch(
          width: 44.0,
          height: 24.0,
          value: _toggleValue,
          padding: 3.0,
          onToggle: (value) {
            setState(() {
              _toggleValue = !_toggleValue;
            });
          },
          activeColor: AppColors.royalBlue,
          toggleSize: 18.0,
        ),
      ],
    );
  }
}
