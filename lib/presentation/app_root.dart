import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// For non-freezed version
import 'package:simple_navigator/application/router_cubit/router_cubit.dart';
import 'router/root_router_delegate.dart';
// For freezed version
import 'package:simple_navigator/application/freezed_router/freezed_router_cubit.dart';
import 'freezed_router/root_freezed_router_delegate.dart';

class AppRoot extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // true - use freezed version; false - use non-freezed version
  static const bool _useFreezed = true;

  AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FreezedRouterCubit(),
          ),
          BlocProvider(
            create: (context) => RouterCubit(),
          ),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
            theme: ThemeData.from(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
              ).copyWith(secondary: Colors.yellow),
            ),
            home: _useFreezed ? _freezedRouter : _router,
          ),
        ),
      );

  Widget get _router => BlocBuilder<RouterCubit, RouterState>(
        builder: (context, state) => Router(
          routerDelegate: RootRouterDelegate(
            navigatorKey,
            context.read<RouterCubit>(),
          ),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      );

  Widget get _freezedRouter => BlocBuilder<FreezedRouterCubit, FreezedRouterState>(
        builder: (context, state) => Router(
          routerDelegate: RootFreezedRouterDelegate(
            navigatorKey,
            context.read<FreezedRouterCubit>(),
          ),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      );
}
