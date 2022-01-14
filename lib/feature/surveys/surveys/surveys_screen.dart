import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/data_blocs/auth/auth_bloc.dart';
import 'package:v24_student_app/utils/ui.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({Key? key}) : super(key: key);

  @override
  _SurveysScreenState createState() => _SurveysScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('surveys'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.authBloc;
        },
        child: const SurveysScreen(),
        lazy: false,
      ),
    );
  }
}

class _SurveysScreenState extends State<SurveysScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              body: Container(
            color: Colors.blueGrey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text(
                    'Surveys Screen',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  InkWell(
                    onTap: () {
                      // BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutEvent(context: context));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25), color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red, fontSize: 30),
                        )),
                  ),
                ],
              ),
            ),
          ));
        });
  }
}
