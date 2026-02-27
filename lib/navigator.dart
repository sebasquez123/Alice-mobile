import 'dart:async';
import 'dart:io';

import 'package:alice/config.dart';
import 'package:alice/daddy.dart';
import 'package:alice/features/home/view/home.dart';
import 'package:alice/features/login/view/login.dart';
import 'package:alice/features/quotation/view/quotation.dart';
import 'package:alice/features/registry/view/registry.dart';
import 'package:alice/features/terms/view/terms.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final logger = LoggerConfig(instanceName: 'Navigator');

class Routes {
  static const String home = '/home';
  static const String signIn = '/sign-in';
  static const String quotation = '/quotation';
  static const String terms = '/terms-of-service';
  static const String quoteRegistry = '/quote-registry';
}

class PageStack {
  final String pageName;
  final IconData pageIcon;
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
      pageIcon: Icons.home,
      pageRedirectPath: Routes.home,
      iconToolTip: 'Go Home',
    ),
    PageStack(
      pageName: Routes.quotation.replaceAll('/', ''),
      pageIcon: Icons.store,
      pageRedirectPath: Routes.quotation,
      iconToolTip: 'Go Quotation',
    ),
    PageStack(
      pageName: Routes.terms.replaceAll('/', ''),
      pageIcon: Icons.shield,
      pageRedirectPath: Routes.terms,
      iconToolTip: 'Go Terms of Service',
    ),
    PageStack(
      pageName: Routes.quoteRegistry.replaceAll('/', ''),
      pageIcon: Icons.heart_broken_sharp,
      pageRedirectPath: Routes.quoteRegistry,
      iconToolTip: 'Go Quote Registry',
    ),
    PageStack(
      pageName: Routes.signIn.replaceAll('/', ''),
      pageIcon: Icons.person,
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
      name: Routes.quoteRegistry,
      path: Routes.quoteRegistry,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: RegistryScreen(),
        ),
        transitionsBuilder:  (context, animation, secondaryAnimation, child) => 
        FadeTransition(opacity: animation, child: child)
      ),
    ),
    GoRoute(
      name: Routes.terms,
      path: Routes.terms,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const _AppNavigator(
          child: TermsScreen(),
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
        child: DaddyScreen(child: child),
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
      
      case Routes.quoteRegistry:
        logger.info('Navigating from quote registry screen to home');
        context.replaceNamed(Routes.home);
        break;

      case Routes.terms:
        logger.info('Navigating from terms screen to home');
        context.replaceNamed(Routes.home);
        break;

      default:
        logger.warning('No path found, returning to home');
        context.replaceNamed(Routes.home);
        break;
    }
  }