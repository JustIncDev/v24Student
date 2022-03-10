import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';
import 'data_blocs/profile/owner_profile_bloc.dart';

///Provider for providing blocs globally
class GlobalBlocProvider extends StatelessWidget {
  const GlobalBlocProvider({
    Key? key,
    required this.child,
    required this.loggedIn,
  }) : super(key: key);

  final Widget child;
  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    final blocFactory = Provider.of<BlocFactory>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<OwnerProfileBloc>(
          create: (_) => blocFactory.ownerProfileBloc,
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
