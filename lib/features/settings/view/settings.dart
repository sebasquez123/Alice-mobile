import 'package:alice/config.dart';
import 'package:alice/navigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final logger = LoggerConfig(instanceName: 'Settings');

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: const Text('Alice'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              Text(
                'Settings page!',
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
      ),
    );
}