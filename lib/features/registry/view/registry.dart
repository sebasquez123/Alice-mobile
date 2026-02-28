import 'package:alice/config.dart';
import 'package:alice/features/registry/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';


final logger = LoggerConfig(instanceName: 'Registry');

class RegistryScreen extends StatefulWidget {
  const RegistryScreen({super.key});

  @override
  State<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends State<RegistryScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            color: ColorProvider.registryBackground,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registry page!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),                
              ],
            ),
          ),
        ),
    );
}