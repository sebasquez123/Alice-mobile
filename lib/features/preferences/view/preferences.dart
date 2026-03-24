import 'package:alice/config.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';


final logger = LoggerConfig(instanceName: 'Preferences');

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            color: ColorProvider.preferencesBackground,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Preferences page!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
    );
}