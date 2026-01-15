import 'dart:async';
import 'dart:io';

import 'package:alice/config.dart';
import 'package:alice/features/home/view/home.dart';
import 'package:alice/features/login/view/login.dart';
import 'package:alice/features/quotation/view/quotation.dart';
import 'package:alice/features/settings/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final logger = LoggerConfig(instanceName: 'Navigator');

class Routes {
  static const String home = '/';
  static const String signIn = '/sign-in';
  static const String quotation = '/quotation';
  static const String settings = '/settings';
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: Routes.home,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: HomeScreen(),
        ),
        transitionsBuilder:  (context, animation, secondaryAnimation, child) => 
        FadeTransition(opacity: animation, child: child)
      ),
    ),
    GoRoute(
      name: 'sign-in',
      path: Routes.signIn,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: LoginScreen(),
        ),
        transitionsBuilder:  (context, animation, secondaryAnimation, child) => 
        FadeTransition(opacity: animation, child: child)
      ),
    ),
    GoRoute(
      name: 'quotation',
      path: Routes.quotation,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: QuotationScreen(),
        ),
        transitionsBuilder:  (context, animation, secondaryAnimation, child) => 
        FadeTransition(opacity: animation, child: child)
      ),
    ),
    GoRoute(
      name: 'settings',
      path: Routes.settings,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: SettingsScreen(),
        ),
        transitionsBuilder:  (context, animation, secondaryAnimation, child) => 
        FadeTransition(opacity: animation, child: child)
      ),
    ),
  ],
);


class _AppNavigator extends StatelessWidget {
  final Widget child;
  const _AppNavigator({
    required this.child,
  });
  
  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didpop, result) async => leaveAppFromNative(context, didpop),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 97, 250),
          body: Center(
            child: child,
          ),
        ),
      );
}

Future<void> leaveAppFromNative(BuildContext context, bool didpop) async {
    if (didpop) return;
    final currentPath = GoRouter.of(context).state.name;
    switch (currentPath) {
      case Routes.signIn:
        logger.info('Walking from sign-in to home');
        context.replaceNamed(Routes.home);
        break;
      case Routes.home:
        exit(0);

      case Routes.quotation:
        logger.info('Walking from quotation screen to home');
        context.replaceNamed(Routes.home);
        break;

      case Routes.settings:
        logger.info('Walking from settings to home');
        context.replaceNamed(Routes.home);
        break;

      default:
        logger.warning('No path found, returning to home');
        context.replaceNamed(Routes.home);
        break;
    }
  }