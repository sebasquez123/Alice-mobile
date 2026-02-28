import 'package:alice/config.dart';
import 'package:alice/features/terms/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';


final logger = LoggerConfig(instanceName: 'Terms');

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            color: ColorProvider.termsBackground,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Terms page!',
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