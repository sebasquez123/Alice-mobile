import 'package:alice/config.dart';
import 'package:alice/features/quotation/domain/index.dart';
import 'package:alice/template/index.dart';
import 'package:flutter/material.dart';


final logger = LoggerConfig(instanceName: 'Quotation');

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Container(
          decoration: BoxDecoration(
            color: ColorProvider.quotationBackground,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quotation page!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
    );
}