import 'package:alice/config.dart';
import 'package:alice/features/login/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';


final logger = LoggerConfig(instanceName: 'Login');

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            color: ColorProvider.loginBackground,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Login page!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  ],
                ),
                
              ],
            ),
          ),
        ),
    );
}