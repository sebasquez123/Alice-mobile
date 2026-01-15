import 'package:alice/config.dart';
import 'package:alice/features/home/domain/bloc/home.bloc.dart';
import 'package:alice/features/home/domain/data/home.state.dart';
import 'package:alice/features/home/domain/events/home.events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


final logger = LoggerConfig(instanceName: 'Home');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        title: const Text('Alice'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            children: [
              BlocConsumer<FactionBloc, FactionState>(
                listener: (context, state) {
                  logger.critical('Faction state changed: ${state.toString()}');
                },
                builder: (context, state) => Column(
                    children: [
                      Text(
                        state.faction,
                        style: const TextStyle(fontSize: 32),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<FactionBloc>().add(ToggleFaction()),
                        child: const Text('Toggle Faction'),
                      ),
                    ],
                  ),
              ),
              Text(
                'Welcome to Alice!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
}