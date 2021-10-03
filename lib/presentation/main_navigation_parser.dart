// import 'package:flutter/material.dart';
// import 'package:nav_test/application/main_navigation/main_navigation_cubit.dart';

// class MainNavigationParser extends RouteInformationParser<MainNavigationState> {
//   const MainNavigationParser();

//   @override
//   Future<MainNavigationState> parseRouteInformation(RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location ?? "");
//     if (uri.pathSegments.length == 0) {
//       return MainNavigationState.page1();
//     } else {
//       if (uri.pathSegments[0] == "page2") {
//         return MainNavigationState.page2();
//       }
//       if (uri.pathSegments[0] == "page3") {
//         return MainNavigationState.page3();
//       }
//       if (uri.pathSegments[0] == "page4") {
//         return _page4RouteParser(uri);
//       }
//     }

//     return const MainNavigationState.mainPage();
//   }

//   @override
//   RouteInformation restoreRouteInformation(MainNavigationState configuration) => RouteInformation(
//         location: configuration.maybeWhen(
//           orElse: () => "/mainPage",
//         ),
//       );
// }
