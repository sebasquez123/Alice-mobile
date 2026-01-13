import 'package:equatable/equatable.dart';

abstract class FactionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleFaction extends FactionEvent {}