import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
            child: Text(
              'Welcome to Home',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
      ),
    );
}