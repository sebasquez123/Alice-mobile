import 'package:equatable/equatable.dart';

class FactionState extends Equatable {
  final String faction;
  final int count;
  const FactionState(this.faction, this.count);

  @override
  List<Object?> get props => [faction, count];
}