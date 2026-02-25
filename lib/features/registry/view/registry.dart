import 'package:alice/config.dart';
import 'package:alice/navigator.dart';
import 'package:alice/widgets/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final logger = LoggerConfig(instanceName: 'Registry');

class RegistryScreen extends StatefulWidget {
  const RegistryScreen({super.key});

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: TopAppBar(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              Text(
                'Registry page!',
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