import 'package:alice/config.dart';
import 'package:alice/features/home/domain/bloc/home.bloc.dart';
import 'package:alice/features/home/domain/data/home.state.dart';
import 'package:alice/features/home/domain/events/home.events.dart';
import 'package:alice/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


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
              Text(
                'Welcome to Alice!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              BlocConsumer<FactionBloc, FactionState>(
                listener: (context, state) {
                  logger.info('Faction changed to: ${state.faction}');
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
              Column(
                spacing: 10,
                children: [
                  ElevatedButton(
                            onPressed: () => context.replaceNamed(Routes.settings),
                            child: const Text('Go settings'),
                          ),
                  ElevatedButton(
                        onPressed: () => context.replaceNamed(Routes.quotation),
                        child: const Text('Go quotation'),
                      ),
                  ElevatedButton(
                    onPressed: () => context.replaceNamed(Routes.signIn),
                    child: const Text('Go signin'),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
}