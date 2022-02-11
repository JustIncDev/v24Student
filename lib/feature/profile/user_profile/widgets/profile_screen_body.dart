import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/global/data_blocs/profile/owner_profile_state.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/global/ui/button/primary_button.dart';
import 'package:v24_student_app/global/ui/dialog/v24_dialog.dart';
import 'package:v24_student_app/global/ui/space.dart';
import 'package:v24_student_app/res/colors.dart';
import 'package:v24_student_app/res/fonts.dart';
import 'package:v24_student_app/res/icons.dart';
import 'package:v24_student_app/res/localization/id_values.dart';

class ProfileScreenBody extends StatefulWidget {
  const ProfileScreenBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  final OwnerProfileState state;

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
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
                                const SizedBox(
                                  width: 24.0,
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
                              foregroundImage:
                                  NetworkImage(widget.state.profile?.profilePicture ?? ''),
                              onForegroundImageError: (_, __) {},
                              child: SvgPicture.asset(
                                AppIcons.myProfileIcon,
                                width: 72,
                                height: 72,
                              ),
                            ),
                            const VerticalSpace(10.0),
                            Center(
                              child: Text(
                                (widget.state.profile?.firstName ?? 'Lorem') +
                                    ' ' +
                                    (widget.state.profile?.lastName ?? 'Ipsum'),
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 18.0,
                                  letterSpacing: -0.3,
                                ).montserrat(fontWeight: AppFonts.semiBold),
                              ),
                            ),
                            const VerticalSpace(38.0),
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
                                    widget.state.profile?.firebasePhone?.phoneNumber ?? '',
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
                                    widget.state.profile?.firebaseEmail?.email ?? '',
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
  }

  void _onLogoutButtonPressed() {
    showDialog(
      useRootNavigator: true,
      builder: (context) {
        return V24Dialog(
          header: SvgPicture.asset(
            AppIcons.logoutIcon,
            width: 64.0,
            height: 64.0,
          ),
          title: Text(
            getStringById(context, StringId.logout),
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 18.0,
            ).montserrat(fontWeight: AppFonts.semiBold),
          ),
          description: Text(
            getStringById(context, StringId.logoutDescription),
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14.0,
            ).montserrat(fontWeight: AppFonts.regular),
          ),
          actions: [
            PrimaryButton(
              titleId: StringId.yes,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                BlocProvider.of<AuthBloc>(context).add(AuthLogoutPerformEvent());
              },
              style: PrimaryButtonStyle.disabled,
            ),
            PrimaryButton(
              titleId: StringId.no,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
      context: context,
    );
  }

  void _onEditProfileButtonTap() {
    RootRouter.of(context)?.push(const ScreenInfo(name: ScreenName.editProfile));
  }
}
