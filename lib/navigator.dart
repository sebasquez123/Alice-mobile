import 'dart:async';
import 'dart:io';

import 'package:alice/app_bar.dart';
import 'package:alice/config.dart';
import 'package:alice/features/home/view/home.dart';
import 'package:alice/features/invoice/view/invoice.dart';
import 'package:alice/features/login/view/login.dart';
import 'package:alice/features/preferences/view/preferences.dart';
import 'package:alice/features/quotation/view/quotation.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final logger = LoggerConfig(instanceName: 'Navigator');

class Routes {
  static const String home = '/home';
  static const String signIn = '/sign-in';
  static const String quotation = '/quotation';
  static const String preferences = '/preferences';
  static const String invoice = '/invoice';
}

class PageStack {
  final String pageName;
  final String pageIcon;
  final String pageRedirectPath;
  final String? iconToolTip;
  PageStack({
    required this.pageName,
    required this.pageIcon,
    required this.pageRedirectPath,
    this.iconToolTip,
  });
}

final List<PageStack> pageObjects = [
    PageStack(
      pageName: Routes.home.replaceAll('/', ''),
      pageIcon: cakeIcon,
      pageRedirectPath: Routes.home,
      iconToolTip: 'Go Home',
    ),
    PageStack(
      pageName: Routes.quotation.replaceAll('/', ''),
      pageIcon: shopIcon,
      pageRedirectPath: Routes.quotation,
      iconToolTip: 'Go Quotation',
    ),
    PageStack(
      pageName: Routes.preferences.replaceAll('/', ''),
      pageIcon: loveIcon,
      pageRedirectPath: Routes.preferences,
      iconToolTip: 'Go preferences',
    ),
    PageStack(
      pageName: Routes.invoice.replaceAll('/', ''),
      pageIcon: billIcon,
      pageRedirectPath: Routes.invoice,
      iconToolTip: 'Go invoice checkout',
    ),
    PageStack(
      pageName: Routes.signIn.replaceAll('/', ''),
      pageIcon: userIcon,
      pageRedirectPath: Routes.signIn,
      iconToolTip: 'Go Sign In',
    ),
  ];


final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      name: Routes.home,
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
      name: Routes.signIn,
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
      name: Routes.quotation,
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
      name: Routes.invoice,
      path: Routes.invoice,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: InvoiceScreen(),
        ),
        transitionsBuilder:  (context, animation, secondaryAnimation, child) => 
        FadeTransition(opacity: animation, child: child)
      ),
    ),
    GoRoute(
      name: Routes.preferences,
      path: Routes.preferences,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: PreferencesScreen(),
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
        child: AppBarScreen(child: child),
      );
}

Future<void> leaveAppFromNative(BuildContext context, bool didpop) async {
    if (didpop) return;
    final currentPath = GoRouter.of(context).state.path;
    switch (currentPath) {
      case Routes.home:
        logger.info('Exiting app from home');
        exit(0);

      case Routes.signIn:
        logger.info('Navigating from sign-in to home');
        context.replaceNamed(Routes.home);
        break;

      case Routes.quotation:
        logger.info('Navigating from quotation screen to home');
        context.replaceNamed(Routes.home);
        break;
      
      case Routes.invoice:
        logger.info('Navigating from invoice checkout screen to home');
        context.replaceNamed(Routes.home);
        break;

      case Routes.preferences:
        logger.info('Navigating from preferences screen to home');
        context.replaceNamed(Routes.home);
        break;

      default:
        logger.warning('No path found, returning to home');
        context.replaceNamed(Routes.home);
        break;
    }
  }