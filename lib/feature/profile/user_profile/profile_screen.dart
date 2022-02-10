import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/feature/profile/user_profile/widgets/profile_screen_body.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'bloc/profile_bloc.dart';

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
        return ProfileScreenBody(state: state);
      },
    );
  }
}
