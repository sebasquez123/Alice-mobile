import 'package:alice/models/adds/adds.dart';
import 'package:equatable/equatable.dart';

class AddsState extends Equatable {
  final List<Adds> adds;
  final bool isLoadingAdds;

  const AddsState({
    this.adds = const [],
    this.isLoadingAdds = false,
  });

  AddsState copyWith({
    List<Adds>? adds,
    bool? isLoadingAdds,
  }) => AddsState(
      adds: adds ?? this.adds,
      isLoadingAdds: isLoadingAdds ?? this.isLoadingAdds,
    );

  @override
  List<Object?> get props => [adds, isLoadingAdds];
}