import 'package:alice/config.dart';
import 'package:alice/navigator.dart';
import 'package:alice/widgets/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final logger = LoggerConfig(instanceName: 'Terms');

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              Text(
                'Terms page!',
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