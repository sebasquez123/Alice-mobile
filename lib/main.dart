import 'package:alice/config.dart';
import 'package:alice/features/home/domain/index.dart';
import 'package:alice/navigator.dart';
import 'package:alice/shared/internet_connection_bloc/bloc/internet_connection.bloc.dart';
import 'package:flutter/material.dart';


void main() {
  config();
  runApp(
    MultiBlocProvider (
        providers: [
          BlocProvider<AddsBloc>(create: (_) => AddsBloc()),
          BlocProvider<InternetCheckerBloc>(create: (_) => InternetCheckerBloc())
        ],
        child: const AliceApp(),     
      )
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

