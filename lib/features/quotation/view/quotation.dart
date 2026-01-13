import 'package:flutter/material.dart';

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Quotation'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
            child: Text(
              'Welcome to Quotation',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
      ),
    );
}