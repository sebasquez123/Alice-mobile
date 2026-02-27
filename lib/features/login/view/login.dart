import 'package:alice/config.dart';
import 'package:alice/navigator.dart';
import 'package:alice/widgets/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final logger = LoggerConfig(instanceName: 'Login');

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              Text(
                'Login page!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                            onPressed: () => context.replaceNamed(Routes.home),
                            child: const Text('Go home'),
                          ),
                ],
              ),
              
            ],
          ),
        ),
    );
}