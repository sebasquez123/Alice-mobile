import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

abstract class InternetCheckerEvent extends Equatable {
  const InternetCheckerEvent();
  
  @override
  List<Object?> get props => [];
}

class InternetStatusChanged extends InternetCheckerEvent {
  final List<ConnectivityResult> connectivityResult;

  const InternetStatusChanged(this.connectivityResult);

  @override
  List<Object?> get props => [connectivityResult];
}

