import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v24_student_app/feature/profile/bloc/profile_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';
import 'package:v24_student_app/utils/ui.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('profile'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createProfileBloc();
        },
        child: const ProfileScreen(),
        lazy: false,
      ),
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
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
                                const VerticalSpace(45.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        AppIcons.arrowLeftIcon,
                                        color: AppColors.transparent,
                                        width: 18.0,
                                        height: 18.0,
                                      ),
                                      iconSize: 18.0,
                                      onPressed: null,
                                    ),
                                    Center(
                                      child: Text(
                                        getStringById(context, StringId.myProfile),
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 18.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.semiBold),
                                      ),
                                    ),
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        AppIcons.logoutIcon,
                                        color: AppColors.black,
                                        width: 24.0,
                                        height: 24.0,
                                      ),
                                      onPressed: _onLogoutButtonPressed,
                                    ),
                                  ],
                                ),
                                const VerticalSpace(34.5),
                                CircleAvatar(
                                  radius: 70.0,
                                  backgroundColor: AppColors.royalBlue,
                                  child: SvgPicture.asset(
                                    AppIcons.myProfileIcon,
                                    width: 72,
                                    height: 72,
                                  ),
                                ),
                                const VerticalSpace(10.0),
                                Center(
                                  child: Text(
                                    'Logan Lerman',
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontSize: 18.0,
                                      letterSpacing: -0.3,
                                    ).montserrat(fontWeight: AppFonts.semiBold),
                                  ),
                                ),
                                Container(
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
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 14.0,
                                    bottom: 14.0,
                                    left: 20.0,
                                    right: 20.0,
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
                                      Text(
                                        getStringById(context, StringId.phoneNumber),
                                        style: const TextStyle(
                                          color: AppColors.royalBlue,
                                          fontSize: 13.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.semiBold),
                                      ),
                                      Text(
                                        '+79198128922',
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 13.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.semiBold),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalSpace(10.0),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 14.0,
                                    bottom: 14.0,
                                    left: 20.0,
                                    right: 20.0,
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
                                      Text(
                                        getStringById(context, StringId.email),
                                        style: const TextStyle(
                                          color: AppColors.royalBlue,
                                          fontSize: 13.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.semiBold),
                                      ),
                                      Text(
                                        'email@emil.com',
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 13.0,
                                          letterSpacing: -0.3,
                                        ).montserrat(fontWeight: AppFonts.semiBold),
                                      ),
                                    ],
                                  ),
                                ),
                                const VerticalSpace(18.0),
                                PrimaryButton(
                                  titleId: StringId.editProfile,
                                  onPressed: _onEditProfileButtonTap,
                                  icon: SvgPicture.asset(AppIcons.penIcon),
                                ),
                                Spacer(),
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

  void _onLogoutButtonPressed() {}

  void _onEditProfileButtonTap() {}
}
