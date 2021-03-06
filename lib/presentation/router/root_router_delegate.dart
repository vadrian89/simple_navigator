import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:simple_navigator/application/router_cubit/router_cubit.dart';
import 'package:simple_navigator/presentation/router/main_screen.dart';
import 'package:simple_navigator/presentation/second_level_screen.dart';

class RootRouterDelegate extends RouterDelegate<RouterState> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final RouterCubit _routerCubit;

  RootRouterDelegate(GlobalKey<NavigatorState> navigatorKey, RouterCubit routerCubit)
      : _navigatorKey = navigatorKey,
        _routerCubit = routerCubit;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        pages: List.from([
          _materialPage(valueKey: "mainScreen", child: const MainScreen()),
          ..._extraPages,
        ]),
        onPopPage: _onPopPageParser,
      );

  bool _onPopPageParser(Route<dynamic> route, dynamic result) {
    if (!route.didPop(result)) return false;
    popRoute();
    return true;
  }

  @override
  Future<bool> popRoute() async {
    if (_extraPages.isNotEmpty) {
      _routerCubit.popExtra();
      return true;
    }
    if (_routerCubit.state is! Page1State) {
      _routerCubit.goToPage1();
      return true;
    }
    return await _confirmAppExit();
  }

  List<Page> get _extraPages {
    String? extraPageContent;
    if (_routerCubit.state is Page1State) {
      extraPageContent = (_routerCubit.state as Page1State).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "page-1-extra",
            child: SecondLevelScreen(text: extraPageContent!),
          ),
      ];
    }
    if (_routerCubit.state is Page2State) {
      extraPageContent = (_routerCubit.state as Page2State).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "page-2-extra",
            child: SecondLevelScreen(text: extraPageContent!),
          ),
      ];
    }
    if (_routerCubit.state is Page3State) {
      extraPageContent = (_routerCubit.state as Page3State).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "page-3-extra",
            child: SecondLevelScreen(text: extraPageContent!),
          ),
      ];
    }
    if (_routerCubit.state is Page4State) {
      extraPageContent = (_routerCubit.state as Page4State).extraPageContent;
      return [
        if (extraPageContent?.isNotEmpty ?? false)
          _materialPage(
            valueKey: "page-4-extra",
            child: SecondLevelScreen(text: extraPageContent!),
          ),
      ];
    }
    return [];
  }

  Future<bool> _confirmAppExit() async =>
      await showDialog<bool>(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Are you sure you want to exit the app?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ) ??
      true;

  Page _materialPage({
    required String valueKey,
    required Widget child,
  }) =>
      MaterialPage(
        key: ValueKey<String>(valueKey),
        child: child,
      );

  //It's not needed for bloc/cubit
  @override
  void addListener(VoidCallback listener) {}

  //It's not needed for bloc/cubit
  @override
  void removeListener(VoidCallback listener) {}

  //It's not needed for now
  @override
  Future<void> setNewRoutePath(RouterState configuration) async {}
}
