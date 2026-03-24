import 'package:alice/config.dart';
import 'package:alice/features/invoice/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';


final logger = LoggerConfig(instanceName: 'Registry');

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            color: ColorProvider.invoiceBackground,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invoice page!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),                
              ],
            ),
          ),
        ),
    );
}