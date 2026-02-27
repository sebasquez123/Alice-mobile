import 'package:alice/config.dart';
import 'package:alice/navigator.dart';
import 'package:alice/widgets/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


final logger = LoggerConfig(instanceName: 'Quotation');

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              Text(
                'Quotation page!',
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