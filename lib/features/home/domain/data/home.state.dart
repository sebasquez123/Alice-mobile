import 'package:alice/models/adds/adds.dart';
import 'package:equatable/equatable.dart';

class AddsState extends Equatable {
  final List<Adds> adds;
  final bool isLoading;

  const AddsState({
    this.adds = const [],
    this.isLoading = false,
  });

  AddsState copyWith({
    List<Adds>? adds,
    bool? isLoading,
  }) => AddsState(
      adds: adds ?? this.adds,
      isLoading: isLoading ?? this.isLoading,
    );

  @override
  List<Object?> get props => [adds, isLoading];
}