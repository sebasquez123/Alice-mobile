import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

class InternetCheckerState extends Equatable {
  final bool thereisinternet;
  final Connectivity connectivity = Connectivity();

  InternetCheckerState ({this.thereisinternet = true});

  InternetCheckerState copyWith({
    bool? thereisinternet,
  }) => InternetCheckerState(
      thereisinternet: thereisinternet ?? this.thereisinternet,
    );

  @override
  List<Object?> get props => [thereisinternet, connectivity];
}
