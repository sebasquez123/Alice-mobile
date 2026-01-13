import 'package:alice/config.dart';
import 'package:alice/features/home/domain/bloc/home.bloc.dart';
import 'package:alice/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  config();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FactionBloc()),
      ],
      child: const AliceApp(),
    ),
  );
}

class AliceApp extends StatelessWidget {
  const AliceApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
      title: 'Alice App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 111, 245)),
      ),
      routerConfig: router,
    );
}

