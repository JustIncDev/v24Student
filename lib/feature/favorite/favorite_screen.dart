import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v24_student_app/feature/favorite/widgets/favorite_screen_body.dart';
import 'package:v24_student_app/global/bloc.dart';
import 'package:v24_student_app/global/navigation/root_router.dart';
import 'package:v24_student_app/global/navigation/screen_info.dart';
import 'package:v24_student_app/utils/ui.dart';

import 'bloc/favorite_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();

  static Page buildPage({Map<String, Object>? params, required BlocFactory blocFactory}) {
    return UiUtils.createPlatformPage(
      key: const ValueKey('favorite'),
      child: BlocProvider(
        create: (ctx) {
          return blocFactory.createFavoriteBloc()..add(FavoriteInitEvent());
        },
        child: const FavoriteScreen(),
        lazy: false,
      ),
    );
  }
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listenWhen: (previous, current) {
        return (previous.status != current.status && current.status == FavoriteScreenStatus.next);
      },
      listener: (context, state) {
        if (state.status == FavoriteScreenStatus.next) {
          RootRouter.of(context)?.push(const ScreenInfo(name: ScreenName.pin));
        }
      },
      builder: (context, state) {
        return const FavoriteScreenBody();
      },
    );
  }
}
