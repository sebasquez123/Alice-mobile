
import 'dart:async';

import 'package:alice/config.dart';
import 'package:alice/shared/internet_connection_bloc/data/internet_connection.data.dart';
import 'package:alice/shared/internet_connection_bloc/event/internet_connection.event.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final logger = LoggerConfig(instanceName: 'InternetCheckerBloc').logger;

class InternetCheckerBloc extends Bloc<InternetCheckerEvent, InternetCheckerState> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  InternetCheckerBloc() : super(InternetCheckerState()) {
    on<InternetStatusChanged>(_onInternetStatusChanged);
    _initInternetChecker();
  }

  void _initInternetChecker() {
    logger.i('Initializing internet connection listener');
    _connectivitySubscription = state.connectivity.onConnectivityChanged.listen(
      (result) => add(InternetStatusChanged(result)),
      onError: (error) => logger.e('Error in connectivity stream: $error'),
    );
  }

  Future<void> _onInternetStatusChanged(
    InternetStatusChanged event,
    Emitter<InternetCheckerState> emit,
  ) async {
    try {
      final bool isConnected = event.connectivityResult.contains(ConnectivityResult.mobile) ||
          event.connectivityResult.contains(ConnectivityResult.wifi) ||
          event.connectivityResult.contains(ConnectivityResult.ethernet);

      logger.i('Connection status: ${isConnected ? 'Connected' : 'Disconnected'}');
      emit(state.copyWith(thereisinternet: isConnected));
    } catch (e) {
      logger.e('Error processing status change: $e');
    }
  }

  @override
  Future<void> close() {
    logger.i('Closing internet connection listener');
    _connectivitySubscription.cancel();
    return super.close();
  }
}